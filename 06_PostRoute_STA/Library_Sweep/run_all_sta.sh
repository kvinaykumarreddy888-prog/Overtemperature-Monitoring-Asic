#!/usr/bin/env bash
set -u

BASE="$HOME/Desktop/overtemp_asic/postroute_sta_original"
OUT="$BASE/sta_16_library_rerun"
PDK="$HOME/.ciel/ciel/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A"
IMAGE="ghcr.io/the-openroad-project/openlane:ff5509f65b17bfa4068d5336495ab1718987ff69"

LIBDIR="$PDK/libs.ref/sky130_fd_sc_hd/lib"
TECHLEF="$PDK/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef"
CELLLEF="$PDK/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef"

mkdir -p "$OUT"
SUMMARY="$OUT/summary.txt"
printf "Library,Setup_WNS_ns,Hold_WNS_ns,Status\n" > "$SUMMARY"

for LIB in "$LIBDIR"/sky130_fd_sc_hd__*.lib; do
    NAME=$(basename "$LIB" .lib)
    echo "Running STA: $NAME"

    cat > "$OUT/run.tcl" <<TCL
read_lef /pdk/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef
read_lef /pdk/libs.ref/sky130_fd_sc_hd/lef/sky130_fd_sc_hd.lef
read_liberty /pdk/libs.ref/sky130_fd_sc_hd/lib/$NAME.lib
read_db /work/overtemp_controller.odb
read_sdc /work/16-overtemp_controller.sdc
set_propagated_clock [all_clocks]
read_spef /work/overtemp_controller_original.nom.spef
puts "LIBRARY: $NAME"
puts "=== SETUP CHECKS ==="
report_checks -path_delay max
report_tns
report_wns
report_worst_slack -max
puts "=== HOLD CHECKS ==="
report_checks -path_delay min
report_tns
report_wns
report_worst_slack -min
exit
TCL

    sudo docker run --rm \
      -v "$BASE:/work:ro" \
      -v "$PDK:/pdk:ro" \
      -v "$OUT:/out" \
      -v "$OUT/run.tcl:/run.tcl:ro" \
      "$IMAGE" \
      /bin/bash -lc ' /build/bin/openroad -exit /run.tcl ' \
      > "$OUT/$NAME.log" 2>&1

    if grep -qiE 'Error:|[[:space:]]ERROR|failed to' "$OUT/$NAME.log"; then
        printf "%s,,,ERROR\n" "$NAME" >> "$SUMMARY"
        echo "ERROR: $NAME — inspect $OUT/$NAME.log"
    else
        printf "%s,,,COMPLETED_CHECK_LOG\n" "$NAME" >> "$SUMMARY"
        echo "Finished: $NAME"
    fi
done

echo "Rerun loop finished. Summary file: $SUMMARY"
