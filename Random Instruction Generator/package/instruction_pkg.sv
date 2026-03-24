package instruction_pkg;

    // ==========================================
    // OPCODE ENUM
    // ==========================================
    typedef enum logic [2:0] {
        ADD,
        SUB,
        AND,
        OR,
        XOR,
        LOAD,
        STORE
    } opcode_t;

    // ==========================================
    // INSTRUCTION CLASS
    // ==========================================
    class instruction;

        // Random fields
        rand opcode_t opcode;

        rand logic [3:0] src_reg1;
        rand logic [3:0] src_reg2;
        rand logic [3:0] dest_reg;

        rand logic [15:0] immediate;

        // ======================================
        // CONSTRAINTS
        // ======================================

        // Register range
        constraint reg_range {
            src_reg1 inside {[0:15]};
            src_reg2 inside {[0:15]};
            dest_reg inside {[0:15]};
        }

        // Immediate range
        constraint imm_range {
            immediate inside {[0:1023]};
        }

        // Logical consistency
        constraint opcode_behavior {

            // Arithmetic ops use registers
            if (opcode inside {ADD, SUB, AND, OR, XOR}) {
                dest_reg != 0; // avoid writing to zero reg (real CPU behavior)
            }

            // LOAD uses immediate
            if (opcode == LOAD) {
                immediate % 4 == 0; // word aligned
            }

            // STORE doesn't need dest
            if (opcode == STORE) {
                dest_reg == 0;
            }
        }

        // ======================================
        // DISPLAY
        // ======================================
        function void display();
            $display("OP=%s | S1=%0d S2=%0d D=%0d IMM=%0d",
                opcode.name(), src_reg1, src_reg2, dest_reg, immediate);
        endfunction

    endclass

endpackage