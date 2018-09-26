lappend auto_path "C:/lscc/diamond/3.10_x64/data/script"
package require simulation_generation
set ::bali::simulation::Para(PROJECT) {SimBarrelShift}
set ::bali::simulation::Para(PROJECTPATH) {C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A}
set ::bali::simulation::Para(FILELIST) {"C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/FlipFlopD.vhd" "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/FlipFlopSR.vhd" "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/andNor.vhd" "C:/Users/asdf1/Documents/DigitalDesign/Practica2DSD/1/A/RegistroCorrimientRotacional.vhd" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"work" "work" "work" "work" }
set ::bali::simulation::Para(COMPLIST) {"VHDL" "VHDL" "VHDL" "VHDL" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_machxo2}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {FFD}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {}
set ::bali::simulation::Para(LANGUAGE) {VHDL}
set ::bali::simulation::Para(SDFPATH)  {}
set ::bali::simulation::Para(ADDTOPLEVELSIGNALSTOWAVEFORM)  {1}
set ::bali::simulation::Para(RUNSIMULATION)  {1}
set ::bali::simulation::Para(HDLPARAMETERS) {}
set ::bali::simulation::Para(POJO2LIBREFRESH)    {}
set ::bali::simulation::Para(POJO2MODELSIMLIB)   {}
::bali::simulation::ActiveHDL_Run
