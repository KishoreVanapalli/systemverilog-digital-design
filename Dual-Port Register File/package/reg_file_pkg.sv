package reg_file_pkg;

    localparam ADDR_WIDTH = 4;
    localparam DATA_WIDTH = 32;

    typedef struct packed {
        logic [ADDR_WIDTH-1:0] addr;
        logic [DATA_WIDTH-1:0] data;
        logic                  en;
    } instr_write;
    
endpackage