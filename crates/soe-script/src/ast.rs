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
    Const { opcode: Option<u8>, val: i32 },
    Flag { base: FlagBase, bit_index: u16 },
    RamByteSigned(u16),
    RamByteUnsigned(u16),
    RamWordSigned(u16),
    RamWordUnsigned(u16),
    TempByteSigned(u16),
    TempByteUnsigned(u16),
    TempWordSigned(u16),
    TempWordUnsigned(u16),
    ArgBit(u8),
    ArgByteSigned(u8),
    ArgByteUnsigned(u8),
    ArgWordSigned(u8),
    ArgWordUnsigned(u8),
    Entity(Entity),
    Rng,
    RngRange(Box<Expr>),
    DialogResponse(Option<Box<Expr>>),
    Unary { op: UnaryOp, expr: Box<Expr> },
    RawUnary { op: u8, expr: Box<Expr> },
    Binary { op: BinaryOp, left: Box<Expr>, right: Box<Expr> },
    TriggerActor,                      // 0x2D: Akteur / Trigger-Index an $0341
    TaskWord0D,                        // 0x2E: Task-Parameter an +0x0D
    TaskWord09,                        // 0x54: Task Sync-Maske an +0x09
    DerefWord(Box<Expr>),              // 0x55: Indirektes Word über Zeiger [$02]
    DerefByte(Box<Expr>),              // 0x56: Indirektes Byte über Zeiger [$02]
    IsPartnerControlled,               // 0x57: Prüft $0F44 == $0F42
    FrameTimerLo,                      // 0x58: Frame-Timer Low-Word an $0B19
    FrameTimerHi,                      // 0x59: Frame-Timer High-Word an $0B1B
    QueryStatusA(Box<Expr>),           // 0x5A: Statusabfrage via $8E:9FA8
    QueryStatusB(Box<Expr>),           // 0x5B: Statusabfrage via $8E:9EBE
    EntityStatDiff(Box<Expr>),         // 0x5C: Entity Status-/HP-Differenz ($2A,Y - $76,Y)
    RawToken(u8),
    Raw(Vec<u8>),
}

impl Expr {
    pub fn const_val(val: i32) -> Self {
        Self::Const { opcode: None, val }
    }
    pub fn ram_byte(addr: u16) -> Self {
        Self::RamByteUnsigned(addr)
    }
    pub fn ram_word(addr: u16) -> Self {
        Self::RamWordUnsigned(addr)
    }
    pub fn temp_byte(addr: u16) -> Self {
        Self::TempByteUnsigned(addr)
    }
    pub fn temp_word(addr: u16) -> Self {
        Self::TempWordUnsigned(addr)
    }
    pub fn arg_byte(arg: u8) -> Self {
        Self::ArgByteUnsigned(arg)
    }
    pub fn arg_word(arg: u8) -> Self {
        Self::ArgWordUnsigned(arg)
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
    LockPlayer(u8),
    UnlockPlayer(u8),
    FadeIn,
    FadeOut,
    SetCameraPos { x: u8, y: u8 },
    PlaySound { channel: u8, id: u8 },
    PlayMusic(u8),
    CameraFollow { x: u8, y: u8 },
    ChangeMap { x: u8, y: u8, map: u16 },
    ResetGame,
    WaitUntil(Expr),
    WaitFrame(Expr),
    WaitAnim(Expr),
    TileState { expr: Expr, word: u16 },
    BgScrollX(Expr),
    BgScrollY(Expr),
    BgScrollSpeed(Expr),
    Bg2ScrollSpeed(Expr),
    GiveMoneyExpr { currency: Expr, amount: Expr },
    TakeMoneyExpr { currency: Expr, amount: Expr },
    SoundCmd28(Expr),
    SoundCmd2A(Expr),
    AddShopItem { item: Expr, count: Expr },
    OpenShopMenu(Expr),
    SetBrightness(Expr),
    SetEntityPalette { target: Expr, palette: Expr },
    DamageEntity { target: Expr, amount: Expr },
    HealEntity { target: Expr, amount: Expr },
    SetEntityHp { target: Expr, hp: Expr },
    SwitchCharacter(Expr),
    AttachCamera(Expr),
    CastAlchemy { opcode: u8, target: Expr, spell: Expr, level: Expr, extra: Vec<Expr> },
    TriggerEntityAction { target: Expr, action: Expr },
    FlashScreen(Expr),
    SetEntityPosRel { target: Expr, dx: Expr, dy: Expr },
    DamageEntity2 { target: Expr, val: Expr },
    IfEqual { left: Expr, right: Expr, target_offset: i16 },
    IfNotEqual { left: Expr, right: Expr, target_offset: i16 },
    PlayEntityAnim { target: Expr, anim: u16, speed: Expr },
    PlayEntityAnimWait { target: Expr, anim: u16, speed: Expr },
    SetEntityPos { target: Expr, x: Expr, y: Expr },
    MoveEntityTo { target: Expr, x: Expr, y: Expr },
    SetEntityPosExpr { target: Expr, x: Expr, y: Expr },
    SetEntityPosFast { opcode: u8, target: Expr, cx: u8, cy: u8 },
    SetEntityPosRelFast { opcode: u8, target: Expr, dx: Expr, dy: Expr },
    SetEntitySpeed { target: Expr, speed: u16 },
    AttachScript { target: Expr, script_id: u16 },
    EntityAction { opcode: u8, target: Expr },
    CameraAction9C(Expr),
    SpawnEntity { b1: u8, b2: u8, b3: u8 },
    SpawnEntityExtra { b1: u8, b2: u8, b3: u8 },
    SpawnNpc { npc_type: u16, param: u16, x: Expr, y: Expr },
    MapEffect5C { arg1: Expr, arg2: Expr },
    SetTileAttr { opcode: u8, target: Expr, attr: u16 },
    SetBgScroll(u16),
    ShowWindowText { window: u8, text_id: u16 },
    HideWindowText(u8),
    SetWindowSize { opcode: u8, window: u8, x: u8, y: u8, w: u8, h: u8 },
    ShowNamingScreen(u16),
    ShowMessage(u16),
    SetBrightnessFast(Expr),
    SetPitch(Expr),
    SetMusicVolume(u8),
    SoundCmd2AExpr(Expr),
    SoundCmd2BExpr(Expr),
    ScriptCmd4E(Expr),
    ScriptCmd7E { arg1: Expr, arg2: Expr, arg3: Expr, arg4: Expr },
    WriteWramByte { target: Expr, val: Expr },
    WriteWramWord { target: Expr, val: Expr },
    CallTableByte(u8),
    CallTableWord(u16),
    SpawnNpcParam { npc_type: u16, param: u16, x: u8, y: u8 },
    ResetWindowDefaults(u8),
    LockPlayerFast { opcode: u8 },
    UnlockPlayerFast { opcode: u8 },
    CallParams { args: Vec<Expr>, addr: u32 },
    CallTableByteParams { args: Vec<Expr>, idx: u8 },
    CallTableWordParams { args: Vec<Expr>, idx: u16 },
    CallRelativeByteParams { args: Vec<Expr>, offset: i8 },
    CallRelativeWordParams { args: Vec<Expr>, offset: i16 },
    ForkParams { args: Vec<Expr>, addr: u32 },
    Yield { opcode: u8 },
    NopSkipByte(u8),
    Nop,
    FadeInMusic,
    FadeOutMusic,
    DisableInterrupts,
    EnableInterrupts,
    WaitPathEnd,
    EnableBg1,
    DisableBg1,
    EnableBg2,
    DisableBg2,
    EntityFaceEntity { a: Expr, b: Expr },
    FaceEachOther { a: Expr, b: Expr },
    ShowHudAll,
    HideHudAll,
    RestoreMainScreenLayers,
    SetSubScreenLayers,
    ClearShopMenu,
    SetCameraBase { x: Expr, y: Expr },
    ShakeScreenComplex(Vec<Expr>),
    EnterMode7Map(Vec<Expr>),
    ShowCurrencyHud,
    UpdateCurrencyHud,
    HideCurrencyHud,
    SetCanineAiTargeting,
    SetRamPairsX8 { w1: u16, w2: u16, b1: u8, b2: u8 },
    SetTempPairsX8 { w1: u16, w2: u16, b1: u8, b2: u8 },
    SetArgPairsX8 { arg1: u8, arg2: u8, b1: u8, b2: u8 },
    SetNpcScript { target: Expr, w1: u16, w2: u16 },
    SetAmbientActorPos { id: u8, x: u16, y: u16 },
    PaletteFadeCustom(Vec<Expr>),
    StartPaletteCycle(Vec<Expr>),
    Raw { opcode: u8, payload: Vec<u8> },
}

impl Instruction {
    pub fn is_terminal(&self) -> bool {
        matches!(
            self,
            Instruction::End
                | Instruction::Return
                | Instruction::SkipNeg(_)
                | Instruction::CameraFollow { .. }
                | Instruction::ChangeMap { .. }
                | Instruction::ResetGame
                | Instruction::EnterMode7Map(_)
        )
    }
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
