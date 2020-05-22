# Uart-CI

This project is a basic test of Github actions working with [verilator](https://www.veripool.org/wiki/verilator) to build a simple verilog uart transmitter module and automatically runs the tests defined in basicUartTest.cpp

The long term goal is to build a feature complete uart module with a wishbone interface and a full verilator-based testing suite and potentially other verification techniques.

## Usage with Basys 3

To run synthesis/implementation and flash the uart transmitter to the Basys 3 board from Digilent run:

	make basys3-flash

which will run the build script to generate the .bit file and run the flashing script to program the board.  This depends on Vivado being installed and uses a non-project workflow. 

The project will connect over the USB uart at 9600 baud and will send the character on SW[7:0] when BTNR is pressed (ex: SW[6] & SW[1] = 0x41 = 'A').
