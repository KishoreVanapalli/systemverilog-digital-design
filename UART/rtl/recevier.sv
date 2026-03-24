module recevier (
    bus_if.recevier recs  
);
    typedef enum logic [1:0] {IDLE=2'b00, DATA=2'b01, STOP=2'b10} state_t;
    state_t state;

    logic [3:0] count;  
    logic [3:0] sample; 

    always_ff @(posedge recs.clk or negedge recs.rst) begin
        if (!recs.rst) begin          
            state  <= IDLE;           
            count  <= 4'b0;
            sample <= 4'b0;
            recs.data_out <= 8'b0; 
        end else if (recs.rx_en) begin 
            case (state)
                IDLE: begin 
                    if (recs.tx == 1'b0) begin
                        if (sample == 4'd7) begin 
                            state  <= DATA;       
                            sample <= 4'b0;
                            count  <= 4'b0;
                        end else begin
                            sample <= sample + 1'b1;
                        end
                    end else begin
                        sample <= 4'b0; 
                    end
                end

                DATA: begin
                    recs.data_out[count] <= recs.tx;

                    if (count == 7)
                        state <= STOP;
                    else
                        count <= count + 1;
                end

                STOP: begin 
                    if (sample == 4'd15) begin    
                        state  <= IDLE;        
                        sample <= 4'b0;
                    end else begin
                        sample <= sample + 1'b1;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule

