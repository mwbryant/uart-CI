#include <stdlib.h>
#include "obj_dir/Vuarttx.h"
#include "verilated.h"
#include <iostream>
#include <bitset>

void tick(Vuarttx *tb) {
  tb->eval();
  tb->clk = 1;
  tb->eval();
  tb->clk = 0; //leave the clock low
  tb->eval();
}

int main(int argc, char **argv) {
	// Initialize Verilators variables
	Verilated::commandArgs(argc, argv);

	Vuarttx *tb = new Vuarttx;

  //Startup
  tick(tb);

  //Send an A
  tb->newDataReady = 1;
  tb->newData = 'A';
  tick(tb);
  
  //Don't send more and put garbage on the data in line
  tb->newDataReady = 0;
  tb->newData = '0';
  tick(tb);
  
  int count = 0; //cycle counter
  bool started = false; // start bit flag
  int bitcount = 0; //tracks how many bits have been recieved
  auto output = std::bitset<8>(0); //records the output message as it appears 

  while(tb->ready==0) { //loop until send complete
    tick(tb);
    count++;
    if(tb->uarttx__DOT__baudClk) {
      tick(tb); //new output on next cycle
      count++;
      if(started) {
        output[bitcount] = tb->tx;         
        bitcount++;
        if(bitcount==8) started = false; // byte recieved
      } else if(!started && tb->tx==0) { //start message recording
        started = true;
      }
    }
  }

  //report result
  std::cout << "done, cycle count = " << count << std::endl;
  std::cout << "sent message = " << output << std::endl;

  if(output != 'A') { //TODO randomly gen character to send
    std::cout << "ERROR: Wrong character recieved: " << static_cast<char>(output.to_ulong()) << std::endl;
    return 1;
  }

  if(count < 114000 || count > 115000) { //should be about 1.14ms for one character at 9600 baud
    std::cout << "ERROR: Invalid message send time : " << count << "0ns" << std::endl;
    return 1;  
  }

  for(int i=0; i<1000; i++) {
    tick(tb);
    if(tb->tx != 1) { //stop bit should be held until new data
      std::cout << "ERROR: Stop bit was not held" << std::endl;
      return 1;
    }
  }

  //cleanup
  delete tb;

  return 0;
  
}
