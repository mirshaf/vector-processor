# Vector Processor

The hardware description of a simple vector processor. A Verilog project for the Digital Systems Design course, Spring 2024.


## Tools
- Verilog
- ModelSim


## Implementation Details

This project aims to design a vector processor capable of processing multiple words simultanously. The difference of this approach, as opposed to normal processors, can be seen below:

![Screenshot 2024-05-17 114821 (1)](https://github.com/mirshaf/vector-processor/assets/119650737/70540880-04c6-444c-9572-6d3186df6aa7)


In this design, a modular approach was taken by breaking the Vector Processor into three main modules: a register file, an ALU, and a memory. The Vector processor was, then, described by putting these modules together. A thorough and detailed explanation of the implementation of this project can be found in the *Documents* directory.

## How to Run

The simulation of the hardware description provided in this project can be done with ModelSim: an enviroment for simulation of hardware description languages such as Verilog, which was used in this project. The module *code -> q7 -> VectorProcessor.v* has been specifically designed to instantiate the vector processor and run many tests on it. All tests will be run automatically by pressing the *simulate* button in ModelSim and choosing the aforementioned module in the window that pops up. The tests have been designed to be thorough and cover many cases, such as everyday use case scenarios, and also edge cases. They are formatted in three classes: 1.Normal tests; 2.Edge cases, such as very large or very small numbers; and 3.Randomly generated tests.

## Results

After a successful simulation run under the default testbench, ModelSim should display the following:

![Screenshot (4474)](https://github.com/mirshaf/vector-processor/assets/119650737/9b60251a-09d2-4aab-8a92-4ecfbb6414ef)

![Screenshot (4475)](https://github.com/mirshaf/vector-processor/assets/119650737/593dd7d8-0496-4772-9620-30d8a6dea242)

![Screenshot (4477)](https://github.com/mirshaf/vector-processor/assets/119650737/c67a966e-7301-4c5e-8913-5378ddcf83a1)

![Screenshot (4476)](https://github.com/mirshaf/vector-processor/assets/119650737/401cb42c-22e5-4887-9c1d-c469a8bc440f)

The report in *Documents->Extra-Report* delves into the details of this simulation, what it means, what are the expected results, and how the functionality of the described vector processor is practically proven by its testbench.

## Author
- [Me](https://github.com/mirshaf)


