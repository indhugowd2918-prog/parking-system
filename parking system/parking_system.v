module parking_system (
    input  wire       clk,
    input  wire       reset,

    input  wire       entry,
    input  wire       exit,

    output reg  [2:0] count,
    output wire [3:0] slot_status,
    output wire       full,
    output wire       empty
);

    // Maximum parking capacity = 4
    parameter CAPACITY = 3'd4;

    // ------------------------------------------------
    // Parking count
    // ------------------------------------------------
    always @(posedge clk) begin

        if (reset) begin
            count <= 3'd0;
        end

        else begin

            // Vehicle enters
            if (entry && !exit && count < CAPACITY)
                count <= count + 1'b1;

            // Vehicle exits
            else if (exit && !entry && count > 0)
                count <= count - 1'b1;

        end
    end

    // ------------------------------------------------
    // Status signals
    // ------------------------------------------------

    assign full  = (count == CAPACITY);
    assign empty = (count == 0);

    // Individual slot status
    // 1 = occupied
    // 0 = available

    assign slot_status[0] = (count >= 1);
    assign slot_status[1] = (count >= 2);
    assign slot_status[2] = (count >= 3);
    assign slot_status[3] = (count >= 4);

endmodule