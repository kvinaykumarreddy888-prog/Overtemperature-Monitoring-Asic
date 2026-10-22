
`timescale 1ns/1ps

module overtemp_controller #(
    parameter integer PERSIST_CYCLES = 8
)(
    input  wire clk,
    input  wire rst_n,

    input  wire overtemp_in,
    input  wire manual_clear,
    input  wire system_enable,

    output wire cooling_enable,
    output wire shutdown,
    output wire warning,
    output wire system_running
);

    // Counter width: sufficient to count up to PERSIST_CYCLES.
    localparam integer COUNTER_WIDTH =
        (PERSIST_CYCLES < 2) ? 1 : $clog2(PERSIST_CYCLES + 1);

    // FSM state encoding.
    localparam [1:0] ST_NORMAL   = 2'b00;
    localparam [1:0] ST_WARNING  = 2'b01;
    localparam [1:0] ST_SHUTDOWN = 2'b10;

    reg [1:0] state;
    reg [COUNTER_WIDTH-1:0] persist_count;

    // Two-flop synchronizers for external digital inputs.
    reg overtemp_meta;
    reg overtemp_sync;

    reg clear_meta;
    reg clear_sync;

    reg enable_meta;
    reg enable_sync;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            overtemp_meta <= 1'b0;
            overtemp_sync <= 1'b0;

            clear_meta <= 1'b0;
            clear_sync <= 1'b0;

            enable_meta <= 1'b0;
            enable_sync <= 1'b0;
        end else begin
            overtemp_meta <= overtemp_in;
            overtemp_sync <= overtemp_meta;

            clear_meta <= manual_clear;
            clear_sync <= clear_meta;

            enable_meta <= system_enable;
            enable_sync <= enable_meta;
        end
    end

    // Sequential protection controller.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state         <= ST_NORMAL;
            persist_count <= {COUNTER_WIDTH{1'b0}};
        end else begin
            case (state)

                ST_NORMAL: begin
                    persist_count <= {COUNTER_WIDTH{1'b0}};

                    if (overtemp_sync) begin
                        if (PERSIST_CYCLES <= 1) begin
                            state <= ST_SHUTDOWN;
                        end else begin
                            state         <= ST_WARNING;
                            persist_count <= 1;
                        end
                    end
                end

                ST_WARNING: begin
                    if (!overtemp_sync) begin
                        // Warning disappeared before the threshold.
                        state         <= ST_NORMAL;
                        persist_count <= {COUNTER_WIDTH{1'b0}};
                    end else begin
                        if (persist_count == PERSIST_CYCLES - 1) begin
                            // Persistent overtemperature detected.
                            state <= ST_SHUTDOWN;
                        end else begin
                            persist_count <= persist_count + 1'b1;
                        end
                    end
                end

                ST_SHUTDOWN: begin
                    // Shutdown stays latched until the temperature
                    // is normal and manual clear is synchronized.
                    if (clear_sync && !overtemp_sync) begin
                        state         <= ST_NORMAL;
                        persist_count <= {COUNTER_WIDTH{1'b0}};
                    end
                end

                default: begin
                    state         <= ST_NORMAL;
                    persist_count <= {COUNTER_WIDTH{1'b0}};
                end

            endcase
        end
    end

    // Combinational status outputs.
    assign shutdown = (state == ST_SHUTDOWN);

    // Warning remains asserted in the latched shutdown state.
    assign warning =
        (state == ST_WARNING) || (state == ST_SHUTDOWN);

    assign cooling_enable = warning;

    // During the warning state, the system may still be running.
    // The shutdown state always prevents the running indication.
    assign system_running =
        enable_sync && (state != ST_SHUTDOWN);

endmodule
