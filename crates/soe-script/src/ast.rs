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
    Const { opcode: Option<u8>, val: i16 },
    Flag { base: FlagBase, bit_index: u16 },
    RamByte { opcode: u8, addr: u16 },
    RamWord { opcode: u8, addr: u16 },
    TempByte { opcode: u8, addr: u16 },
    TempWord { opcode: u8, addr: u16 },
    ArgBit(u8),
    ArgByte { opcode: u8, arg: u8 },
    ArgWord { opcode: u8, arg: u8 },
    Entity(Entity),
    Rng,
    RngRange(Box<Expr>),
    DialogResponse(Option<Box<Expr>>),
    Unary { op: UnaryOp, expr: Box<Expr> },
    RawUnary { op: u8, expr: Box<Expr> },
    Binary { op: BinaryOp, left: Box<Expr>, right: Box<Expr> },
    RawToken(u8),
    Raw(Vec<u8>),
}

impl Expr {
    pub fn const_val(val: i16) -> Self {
        Self::Const { opcode: None, val }
    }
    pub fn ram_byte(addr: u16) -> Self {
        Self::RamByte { opcode: 0x07, addr }
    }
    pub fn ram_word(addr: u16) -> Self {
        Self::RamWord { opcode: 0x09, addr }
    }
    pub fn temp_byte(addr: u16) -> Self {
        Self::TempByte { opcode: 0x0C, addr }
    }
    pub fn temp_word(addr: u16) -> Self {
        Self::TempWord { opcode: 0x0E, addr }
    }
    pub fn arg_byte(arg: u8) -> Self {
        Self::ArgByte { opcode: 0x11, arg }
    }
    pub fn arg_word(arg: u8) -> Self {
        Self::ArgWord { opcode: 0x13, arg }
    }
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
    WriteRam { opcode: u8, addr: u16, expr: Expr },
    WriteTemp { opcode: u8, addr: u16, expr: Expr },
    WriteScriptArg { opcode: u8, arg: u8, expr: Expr },
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
