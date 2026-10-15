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

#[test]
fn test_negative_constants() {
    let source = r#"
    fun test_neg() = 0x978000 {
        TEMP[0x0010] = -100;
        TEMP[0x0012] = -500;
    }
    "#;

    let mut lexer = Lexer::new(source);
    let tokens = lexer.tokenize().expect("Lexing should succeed");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing should succeed");

    let mut compiler = Compiler::new();
    let blocks = compiler.compile_file(&ast).expect("Negative constants must compile");
    let bc = &blocks[0].bytecode;

    // Statement 1: TEMP[0x0010] = -100 -> 0x19, 0x10, 0x00, Token 0x01 | 0x80 = 0x81, (-100 + 256) = 156 = 0x9C
    assert_eq!(bc[0], 0x19);
    assert_eq!(bc[1], 0x10);
    assert_eq!(bc[2], 0x00);
    assert_eq!(bc[3], 0x81); // Token 0x01 | 0x80
    assert_eq!(bc[4], 156);

    // Statement 2: TEMP[0x0012] = -500 -> 0x19, 0x12, 0x00, Token 0x03 | 0x80 = 0x83, (-500 as u16) = 0xFE0C
    assert_eq!(bc[5], 0x19);
    assert_eq!(bc[6], 0x12);
    assert_eq!(bc[7], 0x00);
    assert_eq!(bc[8], 0x83); // Token 0x03 | 0x80
    assert_eq!(bc[9], 0x0C);
    assert_eq!(bc[10], 0xFE);

    // Verify -70000 fails compilation (< -65536)
    let bad_source = r#"
    fun test_bad_neg() = 0x978000 {
        TEMP[0x0010] = -70000;
    }
    "#;
    let mut lexer = Lexer::new(bad_source);
    let tokens = lexer.tokenize().expect("Lexing succeeds");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing succeeds");
    let mut compiler = Compiler::new();
    let res = compiler.compile_file(&ast);
    assert!(res.is_err(), "-70000 must fail compilation (< -65536)");
}

#[test]
fn test_switch_character_and_attach_camera() {
    let source = r#"
    fun test_actors() = 0x978000 {
        switch_character(0);
        attach_camera(0);
        call(0x978294);
        return;
    }
    "#;

    let mut lexer = Lexer::new(source);
    let tokens = lexer.tokenize().expect("Lexing should succeed");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing should succeed");

    let mut compiler = Compiler::new();
    let blocks = compiler.compile_file(&ast).expect("Compilation must succeed");
    let bc = &blocks[0].bytecode;

    // switch_character(0) -> 0x98, expr 0 with end bit -> 0x30 | 0x80 = 0xB0
    assert_eq!(bc[0], 0x98);
    assert_eq!(bc[1], 0xB0);

    // attach_camera(0) -> 0x9B, expr 0 with end bit -> 0x30 | 0x80 = 0xB0
    assert_eq!(bc[2], 0x9B);
    assert_eq!(bc[3], 0xB0);

    // call(0x978294) -> opcode 0x29, script_addr u16
    assert_eq!(bc[4], 0x29);

    // return -> opcode 0x00
    assert_eq!(*bc.last().unwrap(), 0x00);
}

#[test]
fn test_new_everscript_statements() {
    let source = r#"
    fun test_all_new() = 0x978000 {
        lock_player();
        lock_player(0x05);
        unlock_player();
        unlock_player(0x02);
        fade_in();
        fade_out();
        show_text(0x1234);
        show_text_end(0x1234);
        hide_text();
        change_map(10, 20, 0x0030);
        camera_follow(15, 25);
        teleport_local(12, 18);
        set_camera_pos(5, 7);
        wait_frame(10);
        wait_anim(2);
        damage_entity(0xD0, 50);
        heal_entity(0xD1, 100);
        set_entity_hp(0xD0, 250);
        play_sound(0x12);
        play_sound(1, 0x15);
        play_music(0x08);
        give_money(0, 100);
        take_money(0, 50);
        RAM[0x0100] = 42;
        TEMP[0x0020] = 99;
        FLAG[0x0050] = 1;
        end();
    }
    "#;

    let mut lexer = Lexer::new(source);
    let tokens = lexer.tokenize().expect("Lexing must succeed");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing must succeed");

    let mut compiler = Compiler::new();
    let blocks = compiler.compile_file(&ast).expect("Compilation must succeed");
    assert_eq!(blocks.len(), 1);
    let bc = &blocks[0].bytecode;
    assert!(!bc.is_empty());

    // lock_player() -> 0x2C 0x00
    assert_eq!(bc[0], 0x2C);
    assert_eq!(bc[1], 0x00);

    // lock_player(0x05) -> 0x2C 0x05
    assert_eq!(bc[2], 0x2C);
    assert_eq!(bc[3], 0x05);

    // unlock_player() -> 0x2D 0x00
    assert_eq!(bc[4], 0x2D);
    assert_eq!(bc[5], 0x00);

    // unlock_player(0x02) -> 0x2D 0x02
    assert_eq!(bc[6], 0x2D);
    assert_eq!(bc[7], 0x02);

    // fade_in() -> 0x26
    assert_eq!(bc[8], 0x26);

    // fade_out() -> 0x27
    assert_eq!(bc[9], 0x27);

    // show_text(0x1234) -> 0x51 0x34 0x12
    assert_eq!(bc[10], 0x51);
    assert_eq!(bc[11], 0x34);
    assert_eq!(bc[12], 0x12);

    // show_text_end(0x1234) -> 0x52 0x34 0x12
    assert_eq!(bc[13], 0x52);
    assert_eq!(bc[14], 0x34);
    assert_eq!(bc[15], 0x12);

    // hide_text() -> 0x55
    assert_eq!(bc[16], 0x55);

    // change_map(10, 20, 0x0030) -> 0x22 10 20 0x30 0x00
    assert_eq!(bc[17], 0x22);
    assert_eq!(bc[18], 10);
    assert_eq!(bc[19], 20);
    assert_eq!(bc[20], 0x30);
    assert_eq!(bc[21], 0x00);

    // end() -> 0x00
    assert_eq!(*bc.last().unwrap(), 0x00);
}

#[test]
fn test_if_single_skip_optimizations() {
    let source = r#"
    fun test_skips() = 0x978000 {
        if (FLAG[0x0010]) skip(12);
        if (!FLAG[0x0010]) skip(12);
        if (money(0) >= 100) skip(6);
        if (money(0) < 50) skip(4);
        end();
    }
    "#;

    let mut lexer = Lexer::new(source);
    let tokens = lexer.tokenize().expect("Lexing must succeed");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing must succeed");

    let mut compiler = Compiler::new();
    let blocks = compiler.compile_file(&ast).expect("Compilation must succeed");
    assert_eq!(blocks.len(), 1);
    let bc = &blocks[0].bytecode;

    // if (FLAG[0x0010]) skip(12) -> Opcode 0x08, expr FLAG[0x0010], offset 12 (0x000C)
    assert_eq!(bc[0], 0x08);

    // if (!FLAG[0x0010]) skip(12) -> Opcode 0x09, expr FLAG[0x0010], offset 12
    let pos_ifnot = bc.iter().position(|&b| b == 0x09).expect("Should contain opcode 0x09");
    assert!(pos_ifnot > 0);

    // if (money(0) >= 100) skip(6) -> Opcode 0x0A
    let pos_ge = bc.iter().position(|&b| b == 0x0A).expect("Should contain opcode 0x0A");
    assert!(pos_ge > pos_ifnot);

    // if (money(0) < 50) skip(4) -> Opcode 0x0B
    let pos_lt = bc.iter().position(|&b| b == 0x0B).expect("Should contain opcode 0x0B");
    assert!(pos_lt > pos_ge);
}

#[test]
fn test_roundtrip_everscript_compilation() {
    // Test that an everscript function matching a known sequence compiles byte-exact
    let source = r#"
    fun roundtrip_snippet() = 0x978000 {
        lock_player(0x08);
        if (!FLAG[0x002B]) skip(6);
        show_text(0x0EB8);
        hide_text();
        unlock_player(0x08);
        end();
    }
    "#;

    let mut lexer = Lexer::new(source);
    let tokens = lexer.tokenize().expect("Lexing must succeed");
    let mut parser = Parser::new(tokens);
    let ast = parser.parse_file().expect("Parsing must succeed");

    let mut compiler = Compiler::new();
    let blocks = compiler.compile_file(&ast).expect("Compilation must succeed");
    let bc = &blocks[0].bytecode;

    // lock_player(0x08)
    assert_eq!(bc[0], 0x2C);
    assert_eq!(bc[1], 0x08);

    // if (!FLAG[0x002B]) skip(6) -> 0x09, 0x85, 0x2B, 0x00, 0x06, 0x00
    assert_eq!(bc[2], 0x09);
    assert_eq!(bc[3], 0x85);
    assert_eq!(bc[4], 0x2B);
    assert_eq!(bc[5], 0x00);
    assert_eq!(bc[6], 0x06);
    assert_eq!(bc[7], 0x00);

    // show_text(0x0EB8) -> 0x51, 0xB8, 0x0E
    assert_eq!(bc[8], 0x51);
    assert_eq!(bc[9], 0xB8);
    assert_eq!(bc[10], 0x0E);

    // hide_text() -> 0x55
    assert_eq!(bc[11], 0x55);

    // unlock_player(0x08) -> 0x2D, 0x08
    assert_eq!(bc[12], 0x2D);
    assert_eq!(bc[13], 0x08);

    // end() -> 0x00
    assert_eq!(bc[14], 0x00);
}


