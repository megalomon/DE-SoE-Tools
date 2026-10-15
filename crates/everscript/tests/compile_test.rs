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

#[test]
fn test_compile_section10_pot_trader_dialog() {
    let source = r#"
    enum FLAGS {
        MARKT_EINLASS = 0x002B,
        CHOCOBO_EI    = 0x004E,
    }

    fun pot_trader_dialog() = 0x9782AF {
        lock_player(0x08);
        if (!FLAG[FLAGS.MARKT_EINLASS]) {
            skip(6);
        }
        text(0x0EB8);
        TEMP[0x0069] = dialog_response();
        if (TEMP[0x0069] == 0) {
            text(0x0EC1);
            FLAG[FLAGS.CHOCOBO_EI] = 1;
            give_jewels(10);
        }
        text_hide();
        unlock_player(0x08);
        end();
    }
    "#;

    let mut lexer = Lexer::new(source);
    let tokens = lexer.tokenize().expect("Lexing should succeed");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing should succeed");

    let mut compiler = Compiler::new();
    let blocks = compiler.compile_file(&ast).expect("Compilation of section 10 example must succeed");

    assert_eq!(blocks.len(), 1);
    let block = &blocks[0];
    assert_eq!(block.name, "pot_trader_dialog");
    assert_eq!(block.address, Some(0x9782AF));
    assert!(!block.bytecode.is_empty());

    // Verify opcodes:
    // lock_player(0x08) -> 0x2C 0x08
    assert_eq!(block.bytecode[0], 0x2C);
    assert_eq!(block.bytecode[1], 0x08);

    // End is 0x00
    assert_eq!(*block.bytecode.last().unwrap(), 0x00);
}

#[test]
fn test_constants_range() {
    let source = r#"
    fun test_constants() = 0x978000 {
        TEMP[0x0010] = 40000;
        TEMP[0x0012] = 65535;
    }
    "#;

    let mut lexer = Lexer::new(source);
    let tokens = lexer.tokenize().expect("Lexing should succeed");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing should succeed");

    let mut compiler = Compiler::new();
    let blocks = compiler.compile_file(&ast).expect("Values 40000 and 65535 must compile");
    assert_eq!(blocks.len(), 1);

    // Verify 40000 compiles to Token 0x04 with 0x9C40
    // WriteTemp: 0x19, 0x10, 0x00, Expr: 0x04 | 0x80 = 0x84, 0x40, 0x9C
    let bc = &blocks[0].bytecode;
    assert_eq!(bc[0], 0x19);
    assert_eq!(bc[1], 0x10);
    assert_eq!(bc[2], 0x00);
    assert_eq!(bc[3], 0x84); // Token 0x04 with end bit 0x80
    assert_eq!(bc[4], 0x40); // 40000 = 0x9C40
    assert_eq!(bc[5], 0x9C);

    // Verify 70000 fails compilation (> 65535)
    let bad_source = r#"
    fun test_bad() = 0x978000 {
        TEMP[0x0010] = 70000;
    }
    "#;
    let mut lexer = Lexer::new(bad_source);
    let tokens = lexer.tokenize().expect("Lexing succeeds");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing succeeds");
    let mut compiler = Compiler::new();
    let res = compiler.compile_file(&ast);
    assert!(res.is_err(), "70000 must fail compilation");
}

