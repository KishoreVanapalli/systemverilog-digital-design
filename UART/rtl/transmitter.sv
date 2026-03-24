module transmitter (
    bus_if.transmitter trans
);

    typedef enum logic [1:0] {IDLE=2'b00, START=2'b01, DATA=2'b10, STOP=2'b11} state_t;
    state_t state;

    logic [3:0] count;

    always_ff @(posedge trans.clk or negedge trans.rst) begin
        if (!trans.rst) begin
            state <= IDLE;          
            trans.tx <= 1'b1; 
            count <= 4'b0;
        end else if (trans.tx_en) begin
            case (state)
                IDLE: begin         
                    if (trans.enb) begin
                        trans.tx <= 1'b1;
                        state <= START;
                        count <= 4'b0000;
                    end else begin
                        state <= IDLE;
                    end
                end
                START: begin        
                    trans.tx <= 1'b0; 
                    state <= DATA;
                end
                DATA: begin        
                    if (count == 7) begin 
                        state <= STOP;
                        trans.tx <= 1'b1;
                        count <= 4'b0000;
                    end else begin
                        trans.tx <= trans.data_in[count];
                        state <= DATA;
                        count <= count + 4'b0001;
                    end
                end
                STOP: begin         
                    trans.tx <= 1'b1; 
                    state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                    count <= 4'b0000;
                end
            endcase
        end
    end
endmodule
