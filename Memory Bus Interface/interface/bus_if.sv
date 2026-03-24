interface bus_if(input logic clk, rst);

    import inif_packages::*;
    
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] write_data;
    logic [DATA_WIDTH-1:0] read_data;
    logic read;
    logic write;
    logic ready;

    modport cpu (
        input clk,rst,read_data,ready,
        output write_data,write,read,addr
    );

    modport memory (
        input clk,rst,write_data,write,read,addr,
        output read_data,ready
    );

endinterface 