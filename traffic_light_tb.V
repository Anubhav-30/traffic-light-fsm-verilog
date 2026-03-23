module traffic_light_tb;

    reg clk, rst;
    wire [1:0] highway, side;

    traffic_light_fsm uut (
        .clk(clk),
        .rst(rst),
        .highway(highway),
        .side(side)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, traffic_light_tb);

        clk = 0;
        rst = 1;

        #10 rst = 0;

        #200;

        $finish;
    end

endmodule