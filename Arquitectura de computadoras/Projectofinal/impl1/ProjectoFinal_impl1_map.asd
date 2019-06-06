[ActiveSupport MAP]
Device = LCMXO2-7000ZE;
Package = TQFP144;
Performance = 1;
LUTS_avail = 6864;
LUTS_used = 1486;
FF_avail = 6979;
FF_used = 531;
INPUT_LVCMOS25 = 5;
OUTPUT_LVCMOS25 = 23;
IO_avail = 115;
IO_used = 28;
EBR_avail = 26;
EBR_used = 2;
; Begin EBR Section
Instance_Name = ControlUnit.IR_3_0_0;
Type = SP8KC;
Width = 8;
Depth = 256;
REGMODE = NOREG;
RESETMODE = ASYNC;
ASYNC_RESET_RELEASE = ASYNC;
WRITEMODE = NORMAL;
GSR = DISABLED;
Instance_Name = ControlUnit.MAR_1_0_0;
Type = SP8KC;
Width = 8;
Depth = 256;
REGMODE = NOREG;
RESETMODE = SYNC;
WRITEMODE = NORMAL;
GSR = DISABLED;
; End EBR Section
