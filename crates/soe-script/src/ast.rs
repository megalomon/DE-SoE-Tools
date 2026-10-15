// crates/soe-script/src/ast.rs
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum FlagBase {
    Ram,  // $7E:2258
    Temp, // $7E:2834
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum Entity {
    Boy,
    Dog,
    Controlled,
    NonControlled,
    LastEntity,
    Attached,
    Id(u8),
}

impl Entity {
    pub fn from_u8(b: u8) -> Self {
        match b {
            0xD0 => Self::Boy,
            0xD1 => Self::Dog,
            0xD2 => Self::Controlled,
            0xD3 => Self::NonControlled,
            0xAD => Self::LastEntity,
            0xAE => Self::Attached,
            other => Self::Id(other),
        }
    }

    pub fn to_u8(self) -> u8 {
        match self {
            Self::Boy => 0xD0,
            Self::Dog => 0xD1,
            Self::Controlled => 0xD2,
            Self::NonControlled => 0xD3,
            Self::LastEntity => 0xAD,
            Self::Attached => 0xAE,
            Self::Id(id) => id,
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum UnaryOp {
    Not, // ! (0x14)
    BitNot, // ~ (0x15)
    Neg, // - (0x16)
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum BinaryOp {
    Add,    // + (0x1A)
    Sub,    // - (0x1B)
    Mul,    // * (0x17)
    Div,    // / (0x18)
    Shl,    // << (0x1C)
    Shr,    // >> (0x1D)
    Lt,     // < (0x1E)
    Gt,     // > (0x1F)
    Le,     // <= (0x20)
    Ge,     // >= (0x21)
    Eq,     // == (0x22)
    Ne,     // != (0x23)
    BitAnd, // & (0x24)
    BitOr,  // | (0x25)
    BitXor, // ^ (0x26)
    Or,     // || (0x27)
    And,    // && (0x28)
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum Expr {
    Const(i16),
    Flag { base: FlagBase, bit_index: u16 },
    RamByte(u16),
    RamWord(u16),
    TempByte(u16),
    TempWord(u16),
    ArgByte(u8),
    ArgWord(u8),
    Entity(Entity),
    Rng,
    RngRange(Box<Expr>),
    DialogResponse,
    Unary { op: UnaryOp, expr: Box<Expr> },
    Binary { op: BinaryOp, left: Box<Expr>, right: Box<Expr> },
    Raw(Vec<u8>),
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub enum Instruction {
    End,
    Return,
    Skip(i16),
    SkipNeg(i8),
    Call(u32),
    Fork(u32),
    CallRelative(i16),
    CallRelativeByte(i8),
    If { cond: Expr, target_offset: i16 },
    IfNot { cond: Expr, target_offset: i16 },
    IfMoneyGe { currency: Expr, amount: u32, target_offset: i16 },
    IfMoneyLt { currency: Expr, amount: u32, target_offset: i16 },
    SetFlag { base: FlagBase, bit_index: u16, val: Expr },
    SetScriptArgBit { bit_index: u8, val: Expr },
    WriteRam { addr: u16, expr: Expr },
    WriteTemp { addr: u16, expr: Expr },
    WriteScriptArg { arg: u8, expr: Expr },
    WriteVarFast { addr: u16, val: u16 },
    ShowText(u16),
    ShowTextEnd(u16),
    HideText,
    GiveMoney { currency: Expr, amount: u32 },
    TakeMoney { currency: Expr, amount: u32 },
    GiveJewels(u32),
    Sleep(u8),
    SleepWord(u16),
    Raw { opcode: u8, payload: Vec<u8> },
}

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ScriptStatement {
    pub offset: usize,
    pub snes_addr: u32,
    pub raw_bytes: Vec<u8>,
    pub instruction: Instruction,
}

#[derive(Debug, Clone, Default, PartialEq, Serialize, Deserialize)]
pub struct Script {
    pub start_addr: u32,
    pub statements: Vec<ScriptStatement>,
}
