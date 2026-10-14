// crates/everscript/src/ast.rs
use soe_script::ast::{BinaryOp, FlagBase, UnaryOp};

#[derive(Debug, Clone, PartialEq)]
pub enum EvsExpr {
    Number(i64),
    StringLit(String),
    Ident(String),
    Memory { base: u32, offset: Box<EvsExpr> },
    Flag { base: FlagBase, bit: Box<EvsExpr> },
    Arg(u8),
    ArgBit(u8),
    Money(u8),
    Rng,
    RngRange(Box<EvsExpr>),
    DialogResponse,
    Unary { op: UnaryOp, expr: Box<EvsExpr> },
    Binary { op: BinaryOp, left: Box<EvsExpr>, right: Box<EvsExpr> },
    Call { name: String, args: Vec<EvsExpr> },
}

#[derive(Debug, Clone, PartialEq)]
pub enum EvsStmt {
    Assign { target: EvsExpr, value: EvsExpr },
    If { cond: EvsExpr, then_branch: Vec<EvsStmt>, else_branch: Option<Vec<EvsStmt>> },
    While { cond: EvsExpr, body: Vec<EvsStmt> },
    Call(EvsExpr),
    Return,
    End,
    Text(EvsExpr),
    TextEnd(EvsExpr),
    TextHide,
    GiveJewels(EvsExpr),
    Sleep(EvsExpr),
    Raw { opcode: u8, payload: Vec<u8> },
}

#[derive(Debug, Clone, PartialEq)]
pub struct EvsFunction {
    pub name: String,
    pub address: Option<u32>,
    pub body: Vec<EvsStmt>,
}

#[derive(Debug, Clone, PartialEq)]
pub enum EvsTopLevel {
    Function(EvsFunction),
    Enum { name: String, members: Vec<(String, i64)> },
    Group { name: String, items: Vec<EvsTopLevel> },
    Patch { address: u32, statements: Vec<EvsStmt> },
}

#[derive(Debug, Clone, Default, PartialEq)]
pub struct EvsScriptFile {
    pub items: Vec<EvsTopLevel>,
}
