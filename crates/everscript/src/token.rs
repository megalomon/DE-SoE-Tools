// crates/everscript/src/token.rs

#[derive(Debug, Clone, PartialEq)]
pub enum Token {
    // Keywords
    Fun,
    Def,
    Group,
    Enum,
    If,
    Else,
    While,
    Goto,
    Return,
    End,
    Call,
    Sleep,
    Text,
    TextEnd,
    TextHide,
    GiveJewels,
    GiveMoney,
    TakeMoney,
    Money,
    Arg,
    ArgBit,
    Raw,
    Install,
    Patch,
    True,
    False,
    LockPlayer,
    UnlockPlayer,
    Skip,
    FadeIn,
    FadeOut,
    ChangeMap,
    CameraFollow,
    TeleportLocal,
    SetCameraPos,
    WaitFrame,
    WaitAnim,
    WaitUntil,
    DamageEntity,
    HealEntity,
    SetEntityHp,
    PlaySound,
    PlayMusic,
    SwitchCharacter,
    AttachCamera,
    Fork,
    CallRel,
    ShowMessage,
    Temp,
    Ram,

    // Literals
    Ident(String),
    Number(i64),
    StringLit(String),

    // Symbols & Operators
    Eq,       // ==
    Ne,       // !=
    Le,       // <=
    Ge,       // >=
    Lt,       // <
    Gt,       // >
    Assign,   // =
    Plus,     // +
    Minus,    // -
    Star,     // *
    Slash,    // /
    Shl,      // <<
    Shr,      // >>
    And,      // &&
    Or,       // ||
    BitAnd,   // &
    BitOr,    // |
    BitXor,   // ^
    Not,      // !
    BitNot,   // ~
    OpenParen,    // (
    CloseParen,   // )
    OpenBrace,    // {
    CloseBrace,   // }
    OpenBracket,  // [
    CloseBracket, // ]
    Comma,        // ,
    Semicolon,    // ;
    Colon,        // :
    Dot,          // .
    At,           // @
    Dollar,       // $

    Eof,
}

pub struct Lexer<'a> {
    chars: std::iter::Peekable<std::str::Chars<'a>>,
}

impl<'a> Lexer<'a> {
    pub fn new(input: &'a str) -> Self {
        Self {
            chars: input.chars().peekable(),
        }
    }

    pub fn tokenize(&mut self) -> Result<Vec<Token>, String> {
        let mut tokens = Vec::new();
        while let Some(&c) = self.chars.peek() {
            if c.is_whitespace() {
                self.chars.next();
                continue;
            }

            // Comments
            if c == '/' {
                self.chars.next();
                if let Some(&next) = self.chars.peek() {
                    if next == '/' {
                        // Line comment
                        while let Some(nc) = self.chars.next() {
                            if nc == '\n' {
                                break;
                            }
                        }
                        continue;
                    } else if next == '*' {
                        // Block comment
                        self.chars.next();
                        let mut prev = ' ';
                        while let Some(nc) = self.chars.next() {
                            if prev == '*' && nc == '/' {
                                break;
                            }
                            prev = nc;
                        }
                        continue;
                    } else {
                        tokens.push(Token::Slash);
                        continue;
                    }
                }
            }

            // String literals
            if c == '"' || c == '\'' {
                let quote = c;
                self.chars.next();
                let mut s = String::new();
                let mut closed = false;
                while let Some(nc) = self.chars.next() {
                    if nc == quote {
                        closed = true;
                        break;
                    }
                    s.push(nc);
                }
                if !closed {
                    return Err("Unterminated string literal".to_string());
                }
                tokens.push(Token::StringLit(s));
                continue;
            }

            // Dollar symbol and hex numbers
            if c == '$' {
                self.chars.next(); // consume '$'
                tokens.push(Token::Dollar);
                if self.chars.peek().map(|&ch| ch.is_ascii_hexdigit()).unwrap_or(false) {
                    let mut s = String::new();
                    while let Some(&ch) = self.chars.peek() {
                        if ch.is_ascii_hexdigit() {
                            s.push(ch);
                            self.chars.next();
                        } else {
                            break;
                        }
                    }
                    let val = i64::from_str_radix(&s, 16)
                        .map_err(|e| format!("Ungültiges Hex-Literal '${}': {}", s, e))?;
                    tokens.push(Token::Number(val));
                }
                continue;
            }

            // Numbers
            if c.is_ascii_digit() {
                tokens.push(self.read_number()?);
                continue;
            }

            // Identifiers / Keywords
            if c.is_alphabetic() || c == '_' {
                tokens.push(self.read_ident_or_keyword());
                continue;
            }

            // Multi-char operators
            match c {
                '=' => {
                    self.chars.next();
                    if self.chars.peek() == Some(&'=') {
                        self.chars.next();
                        tokens.push(Token::Eq);
                    } else {
                        tokens.push(Token::Assign);
                    }
                }
                '!' => {
                    self.chars.next();
                    if self.chars.peek() == Some(&'=') {
                        self.chars.next();
                        tokens.push(Token::Ne);
                    } else {
                        tokens.push(Token::Not);
                    }
                }
                '<' => {
                    self.chars.next();
                    if self.chars.peek() == Some(&'=') {
                        self.chars.next();
                        tokens.push(Token::Le);
                    } else if self.chars.peek() == Some(&'<') {
                        self.chars.next();
                        tokens.push(Token::Shl);
                    } else {
                        tokens.push(Token::Lt);
                    }
                }
                '>' => {
                    self.chars.next();
                    if self.chars.peek() == Some(&'=') {
                        self.chars.next();
                        tokens.push(Token::Ge);
                    } else if self.chars.peek() == Some(&'>') {
                        self.chars.next();
                        tokens.push(Token::Shr);
                    } else {
                        tokens.push(Token::Gt);
                    }
                }
                '&' => {
                    self.chars.next();
                    if self.chars.peek() == Some(&'&') {
                        self.chars.next();
                        tokens.push(Token::And);
                    } else {
                        tokens.push(Token::BitAnd);
                    }
                }
                '|' => {
                    self.chars.next();
                    if self.chars.peek() == Some(&'|') {
                        self.chars.next();
                        tokens.push(Token::Or);
                    } else {
                        tokens.push(Token::BitOr);
                    }
                }
                '+' => {
                    self.chars.next();
                    tokens.push(Token::Plus);
                }
                '-' => {
                    self.chars.next();
                    tokens.push(Token::Minus);
                }
                '*' => {
                    self.chars.next();
                    tokens.push(Token::Star);
                }
                '~' => {
                    self.chars.next();
                    tokens.push(Token::BitNot);
                }
                '^' => {
                    self.chars.next();
                    tokens.push(Token::BitXor);
                }
                '(' => { self.chars.next(); tokens.push(Token::OpenParen); }
                ')' => { self.chars.next(); tokens.push(Token::CloseParen); }
                '{' => { self.chars.next(); tokens.push(Token::OpenBrace); }
                '}' => { self.chars.next(); tokens.push(Token::CloseBrace); }
                '[' => { self.chars.next(); tokens.push(Token::OpenBracket); }
                ']' => { self.chars.next(); tokens.push(Token::CloseBracket); }
                ',' => { self.chars.next(); tokens.push(Token::Comma); }
                ';' => { self.chars.next(); tokens.push(Token::Semicolon); }
                ':' => { self.chars.next(); tokens.push(Token::Colon); }
                '.' => { self.chars.next(); tokens.push(Token::Dot); }
                '@' => { self.chars.next(); tokens.push(Token::At); }
                '$' => { self.chars.next(); tokens.push(Token::Dollar); }
                _ => {
                    let unexpected = self.chars.next().unwrap();
                    return Err(format!("Unerwartetes Zeichen: '{}'", unexpected));
                }
            }
        }

        tokens.push(Token::Eof);
        Ok(tokens)
    }

    fn read_number(&mut self) -> Result<Token, String> {
        let mut s = String::new();
        if self.chars.peek() == Some(&'$') {
            self.chars.next();
            while let Some(&c) = self.chars.peek() {
                if c.is_ascii_hexdigit() {
                    s.push(c);
                    self.chars.next();
                } else {
                    break;
                }
            }
            let val = i64::from_str_radix(&s, 16)
                .map_err(|e| format!("Ungültiges Hex-Literal '${}': {}", s, e))?;
            return Ok(Token::Number(val));
        }

        while let Some(&c) = self.chars.peek() {
            if c.is_alphanumeric() || c == 'x' || c == 'X' || c == 'd' || c == 'D' || c == 'b' || c == 'B' {
                s.push(c);
                self.chars.next();
            } else {
                break;
            }
        }

        let val = if s.starts_with("0x") || s.starts_with("0X") {
            i64::from_str_radix(&s[2..], 16)
                .map_err(|e| format!("Ungültiges Hex-Literal '{}': {}", s, e))?
        } else if s.starts_with("0d") || s.starts_with("0D") {
            s[2..].parse::<i64>()
                .map_err(|e| format!("Ungültiges Dezimal-Literal '{}': {}", s, e))?
        } else if s.starts_with("0b") || s.starts_with("0B") {
            i64::from_str_radix(&s[2..], 2)
                .map_err(|e| format!("Ungültiges Binär-Literal '{}': {}", s, e))?
        } else {
            s.parse::<i64>()
                .map_err(|e| format!("Ungültige Zahl '{}': {}", s, e))?
        };

        Ok(Token::Number(val))
    }

    fn read_ident_or_keyword(&mut self) -> Token {
        let mut s = String::new();
        while let Some(&c) = self.chars.peek() {
            if c.is_alphanumeric() || c == '_' {
                s.push(c);
                self.chars.next();
            } else {
                break;
            }
        }

        match s.as_str() {
            "fun" | "function" => Token::Fun,
            "def" => Token::Def,
            "group" => Token::Group,
            "enum" => Token::Enum,
            "if" => Token::If,
            "else" => Token::Else,
            "while" => Token::While,
            "goto" => Token::Goto,
            "return" => Token::Return,
            "end" => Token::End,
            "call" => Token::Call,
            "sleep" | "sleep_aligned" => Token::Sleep,
            "text" | "show_text" => Token::Text,
            "text_end" | "show_text_end" => Token::TextEnd,
            "text_hide" | "hide_text" => Token::TextHide,
            "give_jewels" => Token::GiveJewels,
            "give_money" | "give_money_expr" => Token::GiveMoney,
            "take_money" | "take_money_expr" => Token::TakeMoney,
            "money" => Token::Money,
            "arg" => Token::Arg,
            "arg_bit" => Token::ArgBit,
            "raw" => Token::Raw,
            "install" => Token::Install,
            "patch" => Token::Patch,
            "True" | "true" => Token::True,
            "False" | "false" => Token::False,
            "lock_player" => Token::LockPlayer,
            "unlock_player" => Token::UnlockPlayer,
            "skip" => Token::Skip,
            "fade_in" => Token::FadeIn,
            "fade_out" => Token::FadeOut,
            "change_map" => Token::ChangeMap,
            "camera_follow" => Token::CameraFollow,
            "teleport_local" => Token::TeleportLocal,
            "set_camera_pos" => Token::SetCameraPos,
            "wait_frame" => Token::WaitFrame,
            "wait_anim" => Token::WaitAnim,
            "wait_until" => Token::WaitUntil,
            "damage_entity" => Token::DamageEntity,
            "heal_entity" => Token::HealEntity,
            "set_entity_hp" => Token::SetEntityHp,
            "play_sound" | "play_sfx" => Token::PlaySound,
            "play_music" | "play_bgm" => Token::PlayMusic,
            "switch_character" | "select_entity" => Token::SwitchCharacter,
            "attach_camera" => Token::AttachCamera,
            "fork" => Token::Fork,
            "call_rel" => Token::CallRel,
            "show_message" | "show_text_alt" => Token::ShowMessage,
            "TEMP" | "TEMP_WORD" | "TEMP_BYTE" => Token::Temp,
            "RAM" | "RAM_WORD" | "RAM_BYTE" => Token::Ram,
            _ => Token::Ident(s),
        }
    }
}
