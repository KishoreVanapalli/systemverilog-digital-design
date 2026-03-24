module tb_uart;

    bit clk;
    bit rst;

    always #5 clk = ~clk;

    uart dut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        rst = 0; 
        dut.uart_if.enb = 0;
        dut.uart_if.data_in = 8'h00;

        #20 rst = 1; 
        $display("--- Reset Released at %0t ---", $time);

        @(posedge clk);
        dut.uart_if.data_in = 8'hA5;
        dut.uart_if.enb = 1;
        
        @(posedge clk);
        dut.uart_if.enb = 0; 
        $display("Sent Data: 8'hA5 at %0t", $time);

        #100us; 

        if (dut.uart_if.data_out === 8'hA5)
            $display("SUCCESS: Received matches Sent (8'hA5)");
        else
            $error("FAILURE: Received 8'h%h, Expected 8'hA5", dut.uart_if.data_out);

        @(posedge clk);
        dut.uart_if.data_in = 8'h3C;
        dut.uart_if.enb = 1;
        #10;
        dut.uart_if.enb = 0;

        #100us;

        if (dut.uart_if.data_out === 8'h3C)
            $display("SUCCESS: Received matches Sent (8'h3C)");
        else
            $error("FAILURE: Received 8'h%h, Expected 8'h3C", dut.uart_if.data_out);

        #50us;
        $finish;
    end

endmodule
