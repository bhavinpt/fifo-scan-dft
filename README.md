# Scan Insertion In FIFO (DFT)

Inserted RTL-level scan chain, performed fault detection using test patterns, and analyzed its PPA to observe the cost of scan.

![image](https://github.com/bhavinpt/fifo-scan-dft/assets/117598876/f655d372-3055-4e32-92f7-be8597898756)

The above diagram describes the scan chain insertion around FIFO logic. 
The test pattern is used to set read pointer, write pointer, and FIFO cells with test patterns through SI(scan in) and the output is captured in SO(scan out) when TM(test mode) is enabled.

fifo : contains non-scan RTL with its area, power, and timing reports

fifosc : contains scan based RTL with its area, power, and timing reports

