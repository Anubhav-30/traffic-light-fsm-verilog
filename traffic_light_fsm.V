module traffic_light_fsm (
    input clk,
    input rst,
    output reg [1:0] highway,
    output reg [1:0] side
);

    parameter S0 = 2'b00,  // Highway Green
              S1 = 2'b01,  // Highway Yellow
              S2 = 2'b10,  // Side Green
              S3 = 2'b11;  // Side Yellow

    reg [1:0] state, next_state;
    reg [2:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S0;
            count <= 0;
        end else begin
            if (count == 4) begin
                state <= next_state;
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end
    end

    always @(*) begin
        case (state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S0;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        case (state)
            S0: begin highway = 2'b10; side = 2'b00; end // Green, Red
            S1: begin highway = 2'b01; side = 2'b00; end // Yellow, Red
            S2: begin highway = 2'b00; side = 2'b10; end // Red, Green
            S3: begin highway = 2'b00; side = 2'b01; end // Red, Yellow
            default: begin highway = 2'b00; side = 2'b00; end
        endcase
    end

endmodule