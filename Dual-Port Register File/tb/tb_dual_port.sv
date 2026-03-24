module tb_dual_port;
    bit clk;
    bit rst;

    always #5 clk = ~clk;

    bus_if intf(clk, rst); 

    dual_port dut (.bus(intf));

    initial begin
        rst = 0; 
        intf.w_port.en = 0;

        #20 rst = 1; 
        $display("--- Reset Released at %0t ---", $time);

        @(posedge clk);
        for (int i = 0; i < 16 ; i++) begin
            @(posedge clk);      
            intf.w_port.en   = 1;
            intf.w_port.addr = i;
            intf.w_port.data = i * 10;
        end
        
        @(posedge clk);
        intf.w_port.en = 0; 
        $display("Data write at %0t", $time);

        for (int i = 0; i < 16 ; i++) begin
            @(posedge clk); 
            if (i % 2 == 0) intf.read_addr1 = i;
            else           intf.read_addr2 = i;
        end

        @(posedge clk);
        $display("Data Read at %0t", $time);

        $finish;
    end

endmodule

