# Sis

This project was made for the Computer Architecture's course of the University of Verona year 2023/2024.  
It consists of building a circut to play rock-paper-scissors. Relazione.pdf has all the documentation and Requirements needed (in italian).

## ⚙️Tools
* SIS is an interactive tool for synthesis and optimization of sequential circuits developed by the CAD group of U.C. Berkeley - [Documentation](https://www2.eecs.berkeley.edu/Pubs/TechRpts/1992/2010.html)
* [Verilog](https://en.wikipedia.org/wiki/Verilog) is a hardware description language that is used to realize the digital circuits through code.
  
## 📑Requirements
* Linux OS (for this project Ubuntu was used)
* SIS - [Download link](https://matteoiervasi.it/logic-synthesis/sis.html)
* Verilog - [EDA Playground](https://www.edaplayground.com/)
  * Set Up:
    * Languages & Libraries:
      * Testbench + Design set to SystemVerilog/Verilog
    * Tools & Simulators:
      * set to one of the following options: Mentor QUesta 2021.3, Siemens Questa 2025.2, Icarus Verilog 12.0 (for this project Mentor QUesta 2021.3 was used)
      * Select 'Open EPWave after run'

## 💻Run the project  
Download the repo and unzip it.
* SIS version:
  Inside the sis directory you'll find:
  * non_ottimizzato folder
  * FSMD.blif
  * output_sis.txt (delete/rename it before runngi the programm)
  * testbench.script
  
  ```console
  Console » cd sis
  Console » sis -f testbench.script -x | grep Outputs: > output_sis.txt
  ```
  
* Verilog Version:
  Inside the Verilog directory you'll find:
  * design.sv: source code for the circuit 
  * testbench.sv: simulates the circut
  * output_verilog.txt
    
  Copy 'design.sv' and 'testbench.sv' to EDA Playground and click the RUN button. It will automatically download the .zip with source codes and output.txt file.
    
Both Version's output must be identical. To check copy both output.txt file to the same location then run the following line:

```console
Console » diff output_sis.txt output_verilog.txt
// if it don't print anything both outputs are same
```

## 🎥Demo
