
`timescale 1ns/1ps

module tb_overtemp_controller;

    reg clk;
    reg rst_n;
    reg overtemp_in;
    reg manual_clear;
    reg system_enable;

    wire cooling_enable;
    wire shutdown;
    wire warning;
    wire system_running;

    // Use a short threshold for faster simulation.
    localparam integer TEST_PERSIST_CYCLES = 4;

    overtemp_controller #(
        .PERSIST_CYCLES(TEST_PERSIST_CYCLES)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .overtemp_in(overtemp_in),
        .manual_clear(manual_clear),
        .system_enable(system_enable),
        .cooling_enable(cooling_enable),
        .shutdown(shutdown),
        .warning(warning),
        .system_running(system_running)
    );

    // 100 MHz clock: 10 ns period.
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // Wait for a specified number of rising edges.
    task wait_cycles;
        input integer number_of_cycles;
        integer i;
        begin
            for (i = 0; i < number_of_cycles; i = i + 1)
                @(posedge clk);
            #1;
        end
    endtask

    initial begin
        $dumpfile("overtemp.vcd");
        $dumpvars(0, tb_overtemp_controller);

        rst_n        = 1'b0;
        overtemp_in  = 1'b0;
        manual_clear = 1'b0;
        system_enable = 1'b1;

        // TEST 1: Reset.
        wait_cycles(3);
        @(negedge clk);
        rst_n = 1'b1;
        wait_cycles(5);

        if (shutdown !== 1'b0 ||
            warning !== 1'b0 ||
            cooling_enable !== 1'b0)
            $fatal(1, "TEST 1 FAILED: Reset outputs incorrect");

        if (system_running !== 1'b1)
            $fatal(1, "TEST 1 FAILED: System should be running");

        $display("TEST 1 PASSED: Reset and normal operation");

        // TEST 2: Short warning pulse.
        @(negedge clk);
        overtemp_in = 1'b1;
        wait_cycles(1);

        @(negedge clk);
        overtemp_in = 1'b0;
        wait_cycles(8);

        if (shutdown !== 1'b0)
            $fatal(1, "TEST 2 FAILED: Short pulse caused shutdown");

        if (warning !== 1'b0 || cooling_enable !== 1'b0)
            $fatal(1, "TEST 2 FAILED: Warning did not clear");

        $display("TEST 2 PASSED: Short pulse rejected");

        // TEST 3: Persistent overtemperature.
        @(negedge clk);
        overtemp_in = 1'b1;
        wait_cycles(12);

        if (shutdown !== 1'b1)
            $fatal(1, "TEST 3 FAILED: Persistent warning did not shut down");

        if (warning !== 1'b1 || cooling_enable !== 1'b1)
            $fatal(1, "TEST 3 FAILED: Protection outputs incorrect");

        if (system_running !== 1'b0)
            $fatal(1, "TEST 3 FAILED: System still reports running");

        $display("TEST 3 PASSED: Persistent warning triggers shutdown");

        // TEST 4: Manual clear must not work while hot.
        @(negedge clk);
        manual_clear = 1'b1;
        wait_cycles(4);

        @(negedge clk);
        manual_clear = 1'b0;
        wait_cycles(3);

        if (shutdown !== 1'b1)
            $fatal(1, "TEST 4 FAILED: Shutdown cleared while still hot");

        $display("TEST 4 PASSED: Clear blocked during overtemperature");

        // TEST 5: Cool down, then manually clear.
        @(negedge clk);
        overtemp_in = 1'b0;
        wait_cycles(5);

        @(negedge clk);
        manual_clear = 1'b1;
        wait_cycles(3);

        @(negedge clk);
        manual_clear = 1'b0;
        wait_cycles(4);

        if (shutdown !== 1'b0 ||
            warning !== 1'b0 ||
            cooling_enable !== 1'b0)
            $fatal(1, "TEST 5 FAILED: Manual recovery unsuccessful");

        $display("TEST 5 PASSED: Manual clear after cooldown");

        // TEST 6: Reset clears a newly latched shutdown.
        @(negedge clk);
        overtemp_in = 1'b1;
        wait_cycles(12);

        if (shutdown !== 1'b1)
            $fatal(1, "TEST 6 SETUP FAILED: Shutdown not reached");

        // Deassert the input before reset release so the
        // controller does not immediately retrigger.
        @(negedge clk);
        overtemp_in = 1'b0;
        wait_cycles(4);

        @(negedge clk);
        rst_n = 1'b0;
        wait_cycles(2);

        @(negedge clk);
        rst_n = 1'b1;
        wait_cycles(5);

        if (shutdown !== 1'b0 || warning !== 1'b0)
            $fatal(1, "TEST 6 FAILED: Reset did not clear shutdown");

        $display("TEST 6 PASSED: Reset clears latched shutdown");

        $display("----------------------------------------");
        $display("ALL TESTS PASSED");
        $display("----------------------------------------");

        $finish;
    end

    // Watch key signals in the simulator transcript.
    initial begin
        $monitor(
            "time=%0t rst_n=%b overtemp=%b warning=%b shutdown=%b cooling=%b running=%b",
            $time, rst_n, overtemp_in, warning,
            shutdown, cooling_enable, system_running
        );
    end

endmodule

