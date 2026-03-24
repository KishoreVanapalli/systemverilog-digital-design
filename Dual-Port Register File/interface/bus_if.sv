interface bus_if(input logic clk,rst);

    import reg_file_pkg::*;

    instr_write w_port;
    
    logic [3:0] read_addr1;
    logic [3:0] read_addr2;
    logic [31:0] read_data1;
    logic [31:0] read_data2;

    modport rf_mp (
        input  clk, rst, w_port, read_addr1, read_addr2,
        output read_data1, read_data2
    );

endinterface 