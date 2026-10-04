`timescale 1ns/1ps

module gpio_tb;

    reg clk;
    reg gpio_write;
    reg [3:0] gpio_addr;
    reg [31:0] gpio_wdata;
    reg [31:0] gpio_in;

    wire [31:0] gpio_rdata;
    wire [31:0] gpio_out;

    gpio dut (
        .clk(clk),
        .gpio_write(gpio_write),
        .gpio_addr(gpio_addr),
        .gpio_wdata(gpio_wdata),
        .gpio_in(gpio_in),
        .gpio_rdata(gpio_rdata),
        .gpio_out(gpio_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        gpio_write = 0;
        gpio_addr = 0;
        gpio_wdata = 0;
        gpio_in = 0;

        // Configure all GPIO pins as outputs
        #10;
        gpio_addr = 4'h4;
        gpio_wdata = 32'hFFFFFFFF;
        gpio_write = 1;

        #10;
        gpio_write = 0;

        // Write GPIO data
        gpio_addr = 4'h0;
        gpio_wdata = 32'h12345678;
        gpio_write = 1;

        #10;
        gpio_write = 0;

        #2;
        $display("DATA READ = %h", gpio_rdata);
        $display("GPIO OUT  = %h", gpio_out);

        // Read GPIO pins
        gpio_addr = 4'h8;

        #2;
        $display("GPIO READ = %h", gpio_rdata);

        if (gpio_rdata == 32'h12345678 &&
            gpio_out  == 32'h12345678) begin
            $display("GPIO TEST PASSED");
        end else begin
            $display("GPIO TEST FAILED");
        end

        $finish;
    end

endmodule
