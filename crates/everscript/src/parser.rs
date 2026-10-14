// crates/everscript/src/parser.rs
use crate::ast::*;
use crate::token::Token;
use soe_script::ast::{BinaryOp, FlagBase, UnaryOp};

pub struct Parser {
    tokens: Vec<Token>,
    pos: usize,
}

impl Parser {
    pub fn new(tokens: Vec<Token>) -> Self {
        Self { tokens, pos: 0 }
    }

    pub fn parse_file(&mut self) -> Result<EvsScriptFile, String> {
        let mut file = EvsScriptFile::default();
        while !self.is_at_end() {
            let item = self.parse_top_level()?;
            file.items.push(item);
        }
        Ok(file)
    }

    fn peek(&self) -> &Token {
        &self.tokens[self.pos]
    }

    fn is_at_end(&self) -> bool {
        matches!(self.peek(), Token::Eof)
    }

    fn advance(&mut self) -> Token {
        if !self.is_at_end() {
            self.pos += 1;
        }
        self.tokens[self.pos - 1].clone()
    }

    fn check(&self, token: &Token) -> bool {
        if self.is_at_end() {
            false
        } else {
            std::mem::discriminant(self.peek()) == std::mem::discriminant(token)
        }
    }

    fn match_token(&mut self, token: &Token) -> bool {
        if self.check(token) {
            self.advance();
            true
        } else {
            false
        }
    }

    fn consume(&mut self, token: &Token, err: &str) -> Result<Token, String> {
        if self.check(token) {
            Ok(self.advance())
        } else {
            Err(format!("{} (gefunden: {:?})", err, self.peek()))
        }
    }

    fn parse_top_level(&mut self) -> Result<EvsTopLevel, String> {
        if self.match_token(&Token::At) {
            if let Token::Ident(id) = self.peek() {
                if id == "patch" || id == "install" {
                    self.advance();
                    self.consume(&Token::OpenParen, "Erwarte '(' nach @patch")?;
                    let addr = self.parse_number_const()?;
                    self.consume(&Token::CloseParen, "Erwarte ')' nach Adresse")?;
                    self.consume(&Token::OpenBrace, "Erwarte '{' für Patch-Block")?;
                    let mut statements = Vec::new();
                    while !self.check(&Token::CloseBrace) && !self.is_at_end() {
                        statements.push(self.parse_statement()?);
                    }
                    self.consume(&Token::CloseBrace, "Erwarte '}' nach Patch-Block")?;
                    return Ok(EvsTopLevel::Patch { address: addr as u32, statements });
                }
            }
        }

        if self.match_token(&Token::Group) {
            let name = match self.advance() {
                Token::Ident(n) => n,
                other => return Err(format!("Erwarte Gruppenname, gefunden: {:?}", other)),
            };
            self.consume(&Token::OpenParen, "Erwarte '(' nach Gruppenname")?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach Gruppenname")?;
            self.consume(&Token::OpenBrace, "Erwarte '{' für Gruppen-Inhalt")?;
            let mut items = Vec::new();
            while !self.check(&Token::CloseBrace) && !self.is_at_end() {
                items.push(self.parse_top_level()?);
            }
            self.consume(&Token::CloseBrace, "Erwarte '}' nach Gruppen-Inhalt")?;
            return Ok(EvsTopLevel::Group { name, items });
        }

        if self.match_token(&Token::Enum) {
            let name = match self.advance() {
                Token::Ident(n) => n,
                other => return Err(format!("Erwarte Enum-Name, gefunden: {:?}", other)),
            };
            self.consume(&Token::OpenBrace, "Erwarte '{' nach Enum-Name")?;
            let mut members = Vec::new();
            while !self.check(&Token::CloseBrace) && !self.is_at_end() {
                let mem_name = match self.advance() {
                    Token::Ident(n) => n,
                    other => return Err(format!("Erwarte Enum-Member-Name, gefunden: {:?}", other)),
                };
                self.consume(&Token::Assign, "Erwarte '=' nach Enum-Member")?;
                let val = self.parse_number_const()?;
                self.match_token(&Token::Comma);
                members.push((mem_name, val));
            }
            self.consume(&Token::CloseBrace, "Erwarte '}' nach Enum-Definition")?;
            return Ok(EvsTopLevel::Enum { name, members });
        }

        if self.match_token(&Token::Fun) {
            let name = match self.advance() {
                Token::Ident(n) => n,
                other => return Err(format!("Erwarte Funktionsname, gefunden: {:?}", other)),
            };
            self.consume(&Token::OpenParen, "Erwarte '(' nach Funktionsname")?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach Parametern")?;

            let mut address = None;
            if self.match_token(&Token::Assign) {
                address = Some(self.parse_number_const()? as u32);
            }

            self.consume(&Token::OpenBrace, "Erwarte '{' für Funktionskörper")?;
            let mut body = Vec::new();
            while !self.check(&Token::CloseBrace) && !self.is_at_end() {
                body.push(self.parse_statement()?);
            }
            self.consume(&Token::CloseBrace, "Erwarte '}' nach Funktionskörper")?;
            return Ok(EvsTopLevel::Function(EvsFunction { name, address, body }));
        }

        Err(format!("Unerwarteter Top-Level Token: {:?}", self.peek()))
    }

    fn parse_statement(&mut self) -> Result<EvsStmt, String> {
        if self.match_token(&Token::If) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach if")?;
            let cond = self.parse_expr()?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach if-Bedingung")?;
            self.consume(&Token::OpenBrace, "Erwarte '{' nach if-Bedingung")?;
            let mut then_branch = Vec::new();
            while !self.check(&Token::CloseBrace) && !self.is_at_end() {
                then_branch.push(self.parse_statement()?);
            }
            self.consume(&Token::CloseBrace, "Erwarte '}' nach then-Block")?;

            let mut else_branch = None;
            if self.match_token(&Token::Else) {
                self.consume(&Token::OpenBrace, "Erwarte '{' nach else")?;
                let mut e_branch = Vec::new();
                while !self.check(&Token::CloseBrace) && !self.is_at_end() {
                    e_branch.push(self.parse_statement()?);
                }
                self.consume(&Token::CloseBrace, "Erwarte '}' nach else-Block")?;
                else_branch = Some(e_branch);
            }

            return Ok(EvsStmt::If { cond, then_branch, else_branch });
        }

        if self.match_token(&Token::While) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach while")?;
            let cond = self.parse_expr()?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach while-Bedingung")?;
            self.consume(&Token::OpenBrace, "Erwarte '{' nach while-Bedingung")?;
            let mut body = Vec::new();
            while !self.check(&Token::CloseBrace) && !self.is_at_end() {
                body.push(self.parse_statement()?);
            }
            self.consume(&Token::CloseBrace, "Erwarte '}' nach while-Körper")?;
            return Ok(EvsStmt::While { cond, body });
        }

        if self.match_token(&Token::Return) {
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::Return);
        }

        if self.match_token(&Token::End) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach end")?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach end")?;
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::End);
        }

        if self.match_token(&Token::Call) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach call")?;
            let expr = self.parse_expr()?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach call-Argument")?;
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::Call(expr));
        }

        if self.match_token(&Token::Text) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach text")?;
            let expr = self.parse_expr()?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach text-ID")?;
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::Text(expr));
        }

        if self.match_token(&Token::TextEnd) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach text_end")?;
            let expr = self.parse_expr()?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach text_end-ID")?;
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::TextEnd(expr));
        }

        if self.match_token(&Token::TextHide) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach text_hide")?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach text_hide")?;
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::TextHide);
        }

        if self.match_token(&Token::GiveJewels) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach give_jewels")?;
            let expr = self.parse_expr()?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach give_jewels")?;
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::GiveJewels(expr));
        }

        if self.match_token(&Token::Sleep) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach sleep")?;
            let expr = self.parse_expr()?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach sleep")?;
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::Sleep(expr));
        }

        if self.match_token(&Token::Raw) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach raw")?;
            let opcode = self.parse_number_const()? as u8;
            self.consume(&Token::Comma, "Erwarte ',' nach Opcode")?;
            self.consume(&Token::OpenBracket, "Erwarte '[' für Payload")?;
            let mut payload = Vec::new();
            while !self.check(&Token::CloseBracket) && !self.is_at_end() {
                payload.push(self.parse_number_const()? as u8);
                self.match_token(&Token::Comma);
            }
            self.consume(&Token::CloseBracket, "Erwarte ']' nach Payload")?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach raw")?;
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::Raw { opcode, payload });
        }

        // Zuweisung oder Methodenaufruf
        let expr = self.parse_expr()?;
        if self.match_token(&Token::Assign) {
            let val = self.parse_expr()?;
            self.match_token(&Token::Semicolon);
            return Ok(EvsStmt::Assign { target: expr, value: val });
        }

        self.match_token(&Token::Semicolon);
        Err(format!("Unerwarteter Ausdruck als Anweisung: {:?}", expr))
    }

    pub fn parse_expr(&mut self) -> Result<EvsExpr, String> {
        self.parse_logical_or()
    }

    fn parse_logical_or(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_logical_and()?;
        while self.match_token(&Token::Or) {
            let right = self.parse_logical_and()?;
            left = EvsExpr::Binary { op: BinaryOp::Or, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_logical_and(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_bitwise_or()?;
        while self.match_token(&Token::And) {
            let right = self.parse_bitwise_or()?;
            left = EvsExpr::Binary { op: BinaryOp::And, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_bitwise_or(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_bitwise_xor()?;
        while self.match_token(&Token::BitOr) {
            let right = self.parse_bitwise_xor()?;
            left = EvsExpr::Binary { op: BinaryOp::BitOr, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_bitwise_xor(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_bitwise_and()?;
        while self.match_token(&Token::BitXor) {
            let right = self.parse_bitwise_and()?;
            left = EvsExpr::Binary { op: BinaryOp::BitXor, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_bitwise_and(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_equality()?;
        while self.match_token(&Token::BitAnd) {
            let right = self.parse_equality()?;
            left = EvsExpr::Binary { op: BinaryOp::BitAnd, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_equality(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_relational()?;
        while self.check(&Token::Eq) || self.check(&Token::Ne) {
            let op = if self.match_token(&Token::Eq) { BinaryOp::Eq } else { self.advance(); BinaryOp::Ne };
            let right = self.parse_relational()?;
            left = EvsExpr::Binary { op, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_relational(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_shift()?;
        while self.check(&Token::Lt) || self.check(&Token::Le) || self.check(&Token::Gt) || self.check(&Token::Ge) {
            let op = if self.match_token(&Token::Lt) {
                BinaryOp::Lt
            } else if self.match_token(&Token::Le) {
                BinaryOp::Le
            } else if self.match_token(&Token::Gt) {
                BinaryOp::Gt
            } else {
                self.advance();
                BinaryOp::Ge
            };
            let right = self.parse_shift()?;
            left = EvsExpr::Binary { op, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_shift(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_additive()?;
        while self.check(&Token::Shl) || self.check(&Token::Shr) {
            let op = if self.match_token(&Token::Shl) { BinaryOp::Shl } else { self.advance(); BinaryOp::Shr };
            let right = self.parse_additive()?;
            left = EvsExpr::Binary { op, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_additive(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_multiplicative()?;
        while self.check(&Token::Plus) || self.check(&Token::Minus) {
            let op = if self.match_token(&Token::Plus) { BinaryOp::Add } else { self.advance(); BinaryOp::Sub };
            let right = self.parse_multiplicative()?;
            left = EvsExpr::Binary { op, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_multiplicative(&mut self) -> Result<EvsExpr, String> {
        let mut left = self.parse_unary()?;
        while self.check(&Token::Star) || self.check(&Token::Slash) {
            let op = if self.match_token(&Token::Star) { BinaryOp::Mul } else { self.advance(); BinaryOp::Div };
            let right = self.parse_unary()?;
            left = EvsExpr::Binary { op, left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn parse_unary(&mut self) -> Result<EvsExpr, String> {
        if self.match_token(&Token::Not) {
            let expr = self.parse_unary()?;
            return Ok(EvsExpr::Unary { op: UnaryOp::Not, expr: Box::new(expr) });
        }
        if self.match_token(&Token::BitNot) {
            let expr = self.parse_unary()?;
            return Ok(EvsExpr::Unary { op: UnaryOp::BitNot, expr: Box::new(expr) });
        }
        if self.match_token(&Token::Minus) {
            let expr = self.parse_unary()?;
            return Ok(EvsExpr::Unary { op: UnaryOp::Neg, expr: Box::new(expr) });
        }
        self.parse_primary()
    }

    fn parse_primary(&mut self) -> Result<EvsExpr, String> {
        if let Token::Number(n) = self.peek() {
            let val = *n;
            self.advance();
            return Ok(EvsExpr::Number(val));
        }

        if let Token::StringLit(s) = self.peek() {
            let val = s.clone();
            self.advance();
            return Ok(EvsExpr::StringLit(val));
        }

        if self.match_token(&Token::Dollar) {
            let addr_val = self.parse_number_const()? as u32;
            self.consume(&Token::OpenBracket, "Erwarte '[' nach Basis-Adresse")?;
            let offset = self.parse_expr()?;
            self.consume(&Token::CloseBracket, "Erwarte ']' nach Speicher-Offset")?;
            return Ok(EvsExpr::Memory { base: addr_val, offset: Box::new(offset) });
        }

        if self.match_token(&Token::Arg) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach arg")?;
            let num = self.parse_number_const()? as u8;
            self.consume(&Token::CloseParen, "Erwarte ')' nach arg")?;
            return Ok(EvsExpr::Arg(num));
        }

        if self.match_token(&Token::ArgBit) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach arg_bit")?;
            let num = self.parse_number_const()? as u8;
            self.consume(&Token::CloseParen, "Erwarte ')' nach arg_bit")?;
            return Ok(EvsExpr::ArgBit(num));
        }

        if self.match_token(&Token::Money) {
            self.consume(&Token::OpenParen, "Erwarte '(' nach money")?;
            let num = self.parse_number_const()? as u8;
            self.consume(&Token::CloseParen, "Erwarte ')' nach money")?;
            return Ok(EvsExpr::Money(num));
        }

        if self.match_token(&Token::OpenParen) {
            let expr = self.parse_expr()?;
            self.consume(&Token::CloseParen, "Erwarte ')' nach Ausdruck")?;
            return Ok(expr);
        }

        if let Token::Ident(id) = self.peek() {
            let name = id.clone();
            self.advance();

            if name == "FLAG" || name == "TEMP_FLAG" {
                let base = if name == "FLAG" { FlagBase::Ram } else { FlagBase::Temp };
                self.consume(&Token::OpenBracket, "Erwarte '[' nach FLAG-Name")?;
                let bit = self.parse_expr()?;
                self.consume(&Token::CloseBracket, "Erwarte ']' nach FLAG-Index")?;
                return Ok(EvsExpr::Flag { base, bit: Box::new(bit) });
            }

            if name == "rnd" {
                self.consume(&Token::OpenParen, "Erwarte '(' nach rnd")?;
                self.consume(&Token::CloseParen, "Erwarte ')' nach rnd")?;
                return Ok(EvsExpr::Rng);
            }

            if name == "dialog_response" {
                self.consume(&Token::OpenParen, "Erwarte '(' nach dialog_response")?;
                self.consume(&Token::CloseParen, "Erwarte ')' nach dialog_response")?;
                return Ok(EvsExpr::DialogResponse);
            }

            if self.match_token(&Token::OpenParen) {
                let mut args = Vec::new();
                while !self.check(&Token::CloseParen) && !self.is_at_end() {
                    args.push(self.parse_expr()?);
                    self.match_token(&Token::Comma);
                }
                self.consume(&Token::CloseParen, "Erwarte ')' nach Funktionsargumenten")?;
                return Ok(EvsExpr::Call { name, args });
            }

            let mut full_name = name;
            while self.match_token(&Token::Dot) {
                if let Token::Ident(sub) = self.advance() {
                    full_name.push('.');
                    full_name.push_str(&sub);
                }
            }
            return Ok(EvsExpr::Ident(full_name));
        }

        Err(format!("Unerwarteter primärer Ausdruck: {:?}", self.peek()))
    }

    fn parse_number_const(&mut self) -> Result<i64, String> {
        if self.match_token(&Token::Dollar) {
            return self.parse_number_const();
        }
        match self.advance() {
            Token::Number(n) => Ok(n),
            other => Err(format!("Erwarte konstante Zahl, gefunden: {:?}", other)),
        }
    }
}
