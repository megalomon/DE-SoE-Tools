// crates/everscript/src/ast.rs
use soe_script::ast::{BinaryOp, FlagBase, UnaryOp};

#[derive(Debug, Clone, PartialEq)]
pub enum EvsExpr {
    Number(i64),
    StringLit(String),
    Ident(String),
    Memory { base: u32, offset: Box<EvsExpr> },
    MemorySigned { base: u32, offset: Box<EvsExpr> },
    MemoryByte { base: u32, offset: Box<EvsExpr> },
    MemoryByteSigned { base: u32, offset: Box<EvsExpr> },
    Flag { base: FlagBase, bit: Box<EvsExpr> },
    Arg(u8),
    ArgByte(u8),
    ArgByteSigned(u8),
    ArgWordSigned(u8),
    ArgBit(u8),
    Money(u8),
    Rng,
    RngRange(Box<EvsExpr>),
    DialogResponse(Option<Box<EvsExpr>>),
    Unary { op: UnaryOp, expr: Box<EvsExpr> },
    Binary { op: BinaryOp, left: Box<EvsExpr>, right: Box<EvsExpr> },
    Call { name: String, args: Vec<EvsExpr> },
    Array(Vec<EvsExpr>),
    Entity(soe_script::ast::Entity),
    TriggerActor,
    TaskWord0D,
    TaskWord09,
    DerefWord(Box<EvsExpr>),
    DerefByte(Box<EvsExpr>),
    IsPartnerControlled,
    FrameTimerLo,
    FrameTimerHi,
    QueryStatusA(Box<EvsExpr>),
    QueryStatusB(Box<EvsExpr>),
    EntityStatDiff(Box<EvsExpr>),
    Token(u8),
}

#[derive(Debug, Clone, PartialEq)]
pub enum EvsStmt {
    Assign { target: EvsExpr, value: EvsExpr },
    If { cond: EvsExpr, then_branch: Vec<EvsStmt>, else_branch: Option<Vec<EvsStmt>> },
    While { cond: EvsExpr, body: Vec<EvsStmt> },
    Label(String),
    Goto(String),
    Call(EvsExpr),
    Return,
    End,
    Text(EvsExpr),
    TextEnd(EvsExpr),
    TextHide,
    GiveJewels(EvsExpr),
    GiveMoney { currency: EvsExpr, amount: EvsExpr },
    TakeMoney { currency: EvsExpr, amount: EvsExpr },
    Sleep(EvsExpr),
    LockPlayer(EvsExpr),
    UnlockPlayer(EvsExpr),
    Skip(EvsExpr),
    FadeIn,
    FadeOut,
    ChangeMap { x: EvsExpr, y: EvsExpr, map: EvsExpr },
    CameraFollow { x: EvsExpr, y: EvsExpr },
    SetCameraPos { x: EvsExpr, y: EvsExpr },
    WaitFrame(EvsExpr),
    WaitAnim(EvsExpr),
    WaitUntil(EvsExpr),
    DamageEntity { target: EvsExpr, amount: EvsExpr },
    HealEntity { target: EvsExpr, amount: EvsExpr },
    SetEntityHp { target: EvsExpr, hp: EvsExpr },
    PlaySound { channel: Option<EvsExpr>, id: EvsExpr },
    PlayMusic(EvsExpr),
    SwitchCharacter(EvsExpr),
    AttachCamera(EvsExpr),
    Fork(EvsExpr),
    CallRel(EvsExpr),
    ShowMessage(EvsExpr),
    Raw { opcode: u8, payload: Vec<u8> },
    Command { name: String, args: Vec<EvsExpr> },
    Instruction(soe_script::ast::Instruction),
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
