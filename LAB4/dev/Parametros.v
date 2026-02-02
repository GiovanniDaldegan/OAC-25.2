`ifndef PARAM
 `define PARAM

parameter
   /* Operacoes da ULA */
    ZERO        = 32'd0,
    OPAND       = 5'd0,
    OPOR        = 5'd1,
    OPXOR       = 5'd2,
    OPADD       = 5'd3,
    OPSUB       = 5'd4,
    OPSLT       = 5'd5,
    OPSLTU      = 5'd6,
    OPSLL       = 5'd7,
    OPSRL       = 5'd8,
    OPSRA       = 5'd9,
    OPLUI       = 5'd10,
    OPMUL       = 5'd11,
    OPMULH      = 5'd12,
    OPMULHU     = 5'd13,
    OPMULHSU    = 5'd14,
    OPDIV       = 5'd15,
    OPDIVU      = 5'd16,
    OPREM       = 5'd17,
    OPREMU      = 5'd18,
    OPNULL      = 5'd31, // saída ZERO

    /*OpCodes */
    OPC_LOAD        = 7'b0000011,
    OPC_OPIMM       = 7'b0010011,
    OPC_STORE       = 7'b0100011,
    OPC_RTYPE       = 7'b0110011,
    OPC_BRANCH      = 7'b1100011,
    OPC_JALR        = 7'b1100111,
    OPC_JAL         = 7'b1101111,
    OPC_LUI         = 7'b0110111,

    /* Funct 7 */
    FUNCT7_ADD      = 7'b0000000,
    FUNCT7_SUB      = 7'b0100000,
    FUNCT7_SLT      = 7'b0000000,
    FUNCT7_OR       = 7'b0000000,
    FUNCT7_AND      = 7'b0000000,

    /* Funct 3 */
    FUNCT3_LW       = 3'b010,
    FUNCT3_SW       = 3'b010,
    FUNCT3_ADD      = 3'b000,
    FUNCT3_SUB      = 3'b000,
    FUNCT3_SLT      = 3'b010,
    FUNCT3_OR       = 3'b110,
    FUNCT3_AND      = 3'b111,
    FUNCT3_BEQ      = 3'b000,
    FUNCT3_JALR     = 3'b000,


    /* Endereços */
    TEXT_ADDRESS    = 32'h0040_0000,
    DATA_ADDRESS    = 32'h1001_0000,
    STACK_ADDRESS   = 32'h1001_03FC,
    GP              = DATA_ADDRESS;

/*
 * Seções dos registradores de transição 
 *
 * IF_ID:  0:31 PC,  32:63 PC4, 64:95 Instr
 * ID_EX:  0:31 PC4, 32:36 rd,  37:68 Dado1,  69:100 Dado2,      101:132 Imm, 133:135 WB, 136:137 MEM, 138:154 EX
 * EX_MEM: 0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 Dado2,      101:132 Imm, 133:135 WB, 136:137 MEM
 * MEM_WB: 0:31 PC4, 32:36 rd,  37:68 ResULA, 69:100 MemLeitura, 101:132 Imm, 133:135 WB
 *
 * sinais EX:  0:1 OrigAULA,    2:3 OrigBULA,    4:5 opULA,  6 jalr,   7:9 funct3,  10:16 funct7
 * sinais MEM: 0   LeMem,       1   EscreveMem
 * sinais WB:  0   EscreveReg,  1:2 OrigReg
 */

`define rIF_ID_PC           31:  0
`define rIF_ID_PC4          63: 32
`define rIF_ID_Instr        95: 64

`define rID_EX_PC4          31:  0
`define rID_EX_rd           36: 32
`define rID_EX_Dado1        68: 37
`define rID_EX_Dado2       100: 69
`define rID_EX_Imm         132:101
`define rID_EX_WB          135:133
`define rID_EX_MEM         137:136
`define rID_EX_EX          144:138

`define rEX_MEM_PC4         31:  0
`define rEX_MEM_rd          36: 32
`define rEX_MEM_ResULA      68: 37
`define rEX_MEM_Dado2      100: 69
`define rEX_MEM_Imm        132:101
`define rEX_MEM_WB         135:133
`define rEX_MEM_MEM        137:136

`define rMEM_WB_PC4         31:  0
`define rMEM_WB_rd          36: 32
`define rMEM_WB_ResULA      68: 37
`define rMEM_WB_MemLeitura 100: 69
`define rMEM_WB_Imm        132:101
`define rMEM_WB_WB         135:133

`endif
