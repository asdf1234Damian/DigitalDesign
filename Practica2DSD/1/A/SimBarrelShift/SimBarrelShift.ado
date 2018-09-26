setenv SIM_WORKING_FOLDER .
set newDesign 0
if {![file exists "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/SimBarrelShift/SimBarrelShift.adf"]} { 
	design create SimBarrelShift "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A"
  set newDesign 1
}
design open "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/SimBarrelShift"
cd "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A"
designverincludedir -clear
designverlibrarysim -PL -clear
designverlibrarysim -L -clear
designverlibrarysim -PL pmi_work
designverlibrarysim ovi_machxo2
designverdefinemacro -clear
if {$newDesign == 0} { 
  removefile -Y -D *
}
addfile "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/FlipFlopD.vhd"
addfile "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/FlipFlopSR.vhd"
addfile "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/andNor.vhd"
addfile "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/RegistroCorrimientRotacional.vhd"
vlib "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/SimBarrelShift/work"
set worklib work
adel -all
vcom -dbg -work work "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/FlipFlopD.vhd"
vcom -dbg -work work "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/FlipFlopSR.vhd"
vcom -dbg -work work "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/andNor.vhd"
vcom -dbg -work work "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/RegistroCorrimientRotacional.vhd"
entity FFD
vsim  +access +r FFD   -PL pmi_work -L ovi_machxo2
add wave *
run 1000ns
