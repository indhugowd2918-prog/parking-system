`timescale 1ns/1ps

module parking_system_tb;

    reg clk;
    reg reset;
    reg entry;
    reg exit;

    wire [2:0] count;
    wire [3:0] slot_status;
    wire full;
    wire empty;

    // Instantiate parking system
    parking_system uut (
        .clk(clk),
        .reset(reset),
        .entry(entry),
        .exit(exit),
        .count(count),
        .slot_status(slot_status),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test cases
    initial begin

        // Generate waveform
        $dumpfile("simulation/waveform.vcd");
        $dumpvars(0, parking_system_tb);

        $monitor(
            "Time=%0t | Reset=%b | Entry=%b | Exit=%b | Count=%d | Slots=%b | Full=%b | Empty=%b",
            $time, reset, entry, exit, count, slot_status, full, empty
        );

        // --------------------------------------------
        // Reset system
        // --------------------------------------------
        reset = 1;
        entry = 0;
        exit  = 0;
        #10;

        // Release reset
        reset = 0;

        // --------------------------------------------
        // Vehicle 1 enters
        // --------------------------------------------
        entry = 1;
        exit  = 0;
        #10;

        // Vehicle 2 enters
        entry = 1;
        exit = 0;
        #10;

        // Vehicle 3 enters
        entry = 1;
        exit = 0;
        #10;

        // Vehicle 4 enters
        entry = 1;
        exit = 0;
        #10;

        // Parking is now FULL
        // Try another vehicle
        entry = 1;
        exit = 0;
        #10;

        // Stop entry
        entry = 0;

        // --------------------------------------------
        // Vehicle exits
        // --------------------------------------------
        exit = 1;
        #10;

        // Another vehicle exits
        exit = 1;
        #10;

        // Stop exit
        exit = 0;
        #10;

        // --------------------------------------------
        // Vehicle enters again
        // --------------------------------------------
        entry = 1;
        exit = 0;
        #10;

        // Stop entry
        entry = 0;
        #10;

        // --------------------------------------------
        // Reset
        // --------------------------------------------
        reset = 1;
        #10;

        $finish;

    end

endmodule