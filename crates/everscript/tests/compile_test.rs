use everscript::compiler::Compiler;
use everscript::parser::Parser;
use everscript::token::Lexer;

#[test]
fn test_compile_everscript_source() {
    let source = r#"
    enum FLAGS {
        CHOCOBO_EGG = 0x004E,
        MAGIC_GOURD = 0x0052,
    }

    fun pot_trader() = 0x978712 {
        if (!FLAG[FLAGS.MAGIC_GOURD]) {
            text(0x0F15);
            FLAG[FLAGS.CHOCOBO_EGG] = 1;
            give_jewels(50);
            text_end(0x0F27);
        } else {
            text(0x0F2A);
        }
        end();
    }
    "#;

    let mut lexer = Lexer::new(source);
    let tokens = lexer.tokenize().expect("Lexing should succeed");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing should succeed");

    let mut compiler = Compiler::new();
    let blocks = compiler.compile_file(&ast).expect("Compilation should succeed");

    assert_eq!(blocks.len(), 1);
    let block = &blocks[0];
    assert_eq!(block.name, "pot_trader");
    assert_eq!(block.address, Some(0x978712));
    assert!(!block.bytecode.is_empty());

    println!("Bytecode ({} bytes):", block.bytecode.len());
    println!("{}", block.bytecode.iter().map(|b| format!("{:02X}", b)).collect::<Vec<_>>().join(" "));

    // Verify first instruction is IFNOT (0x09)
    assert_eq!(block.bytecode[0], 0x09);
}
