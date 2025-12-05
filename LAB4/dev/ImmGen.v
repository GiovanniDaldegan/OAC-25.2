/* 
 * Unidade de geração do imediato
 * 
 * Suporta as operações:
 * Tipo-I: opcodes 13, 03, 67 (jalr)
 * Tipo-U: opcode 37
 * Tipo-S
 * Tipo-B
 * Tipo-J (jal)
 */

`include "Parametros.v"

module ImmGen (
    input        [31:0] iInstrucao,
    output logic [31:0] oImm
);


always @ (*)
    case (iInstrucao[6:0])
        OPC_LOAD,
        OPC_OPIMM,
        OPC_JALR:
            oImm <= {{20{iInstrucao[31]}}, iInstrucao[31:20]};
        OPC_STORE:
            oImm <= {{20{iInstrucao[31]}}, iInstrucao[31:25], iInstrucao[11:7]};
        OPC_BRANCH:
            oImm <= {{20{iInstrucao[31]}}, iInstrucao[7], iInstrucao[30:25], iInstrucao[11:8], 1'b0};
        OPC_JAL:
            oImm <= {{12{iInstrucao[31]}}, iInstrucao[19:12], iInstrucao[20], iInstrucao[30:21], 1'b0};
        OPC_LUI:
            oImm <= {iInstrucao[31:12], {12{1'b0}}};
        default:
            oImm <= ZERO;
    endcase


endmodule
