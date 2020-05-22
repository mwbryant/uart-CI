VERILOG_SOURCE = $(wildcard *.v)

basys3.bit: $(VERILOG_SOURCE)
	cd basys3 && vivado -mode batch -source basys3build.tcl -nolog -nojournal

basys3-flash: basys3.bit
	cd basys3 && vivado -mode batch -source basys3flash.tcl -nolog -nojournal
