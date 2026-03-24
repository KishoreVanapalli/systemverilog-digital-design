`timescale 1ns/1ps

import instruction_pkg::*;

module tb_instruction;

    instruction instr;

    int opcode_count[opcode_t];

    initial begin
        instr = new();

        $display("===== RANDOM INSTRUCTION GENERATION =====");

        repeat (200) begin
            if (!instr.randomize()) begin
                $fatal("Randomization FAILED");
            end

            instr.display();

            // Track distribution
            opcode_count[instr.opcode]++;
        end

        // ======================================
        // DISTRIBUTION REPORT
        // ======================================
        $display("\n===== OPCODE DISTRIBUTION =====");

        foreach (opcode_count[i]) begin
            $display("%s : %0d", i.name(), opcode_count[i]);
        end

        $finish;
    end

endmodule