#include <stdlib.h>
#include "obj_dir/Vuarttx.h"
#include "verilated.h"
#include <iostream>

int main(int argc, char **argv) {
	// Initialize Verilators variables
	Verilated::commandArgs(argc, argv);

	Vuarttx *tb = new Vuarttx;

  //horrid code but it gets the point across
  //Startup
  tb->clk = 1;
  tb->eval();

  //Send an A
  tb->clk = 0;
  tb->newDataReady = 1;
  tb->newData = 'A';
  tb->eval();

  tb->clk = 1;
  tb->eval();

  //Don't send more and put garbage on the data in line
  tb->clk = 0;
  tb->newDataReady = 0;
  tb->newData = '0';
  tb->eval();

  tb->clk = 1;
  tb->eval();
  
  int count = 0;
  while(tb->ready==0) { //loop until send complete
    tb->clk = 0;
    tb->eval();
    tb->clk = 1;
    tb->eval();
    count++;
  }

  //cleanup
  delete tb;

  //report result
  std::cout << "done, cycle count = " << count << std::endl;
  //if(count > 110000 && count < 120000) { //should be about 114us
  if(count > 100000 && count < 110000) { //edited for force failing test
    return 0;  //sucess
  }
  //failure
  return 1;
  
}
