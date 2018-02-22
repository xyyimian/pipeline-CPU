This project is a CPU simulator with a pipeline function run on ISE 14.7.
The CPU has following functions:
* pipeline (which means one instruction operated in a clock)
* forwarding and bubble insertion
* interrupt (such as instruction interrupt, exception break)
* achieve several instructions such as add, bgtz, lw, sw and so on.
Some notes:
* The CPU takes HARC rather than Von Neumann Architecture which means there are data memory as well as instructions memory.
* The detailed function of various modules and several test samples are written in labreport.
