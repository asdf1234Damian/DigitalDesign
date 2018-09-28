<<<<<<< HEAD
setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Sim/Sim.adf"]} { 
	design create Sim "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD"
  set newDesign 1
}
design open "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Sim"
cd "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo2
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Practica1.vhd"
vlib "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Sim/work"
set worklib work
adel -all
vcom -dbg -work work "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Practica1.vhd"
entity seisEntradas
vsim  +access +r seisEntradas   -PL pmi_work -L ovi_machxo2
add wave *
run 1000ns
=======
setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Sim/Sim.adf"]} { 
	design create Sim "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD"
  set newDesign 1
}
design open "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Sim"
cd "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo2
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Practica1.vhd"
vlib "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Sim/work"
set worklib work
adel -all
vcom -dbg -work work "C:/Users/asdf1/Documents/DigitalDesign/Practica1DSD/Practica1.vhd"
entity seisEntradas
vsim  +access +r seisEntradas   -PL pmi_work -L ovi_machxo2
add wave *
run 1000ns
>>>>>>> 1e0159934712de369f90e4d4827110fd69e68344
