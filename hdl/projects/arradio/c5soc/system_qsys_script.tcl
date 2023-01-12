set project_name arradio_c5soc
set mmu_enabled 1
set ad_hdl_dir /home/guest/hdl_repo/jemfg/jemfgeronimo_hdl/hdl
package require qsys
set_module_property NAME {system_bd}
set_project_property DEVICE_FAMILY {Cyclone V}
set_project_property DEVICE 5CSXFC6D6F31C8ES
foreach {param value} {} { set ad_project_params($param) $value }
source system_qsys.tcl
set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {4}
set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {AUTO}
set_interconnect_requirement {$system} {qsys_mm.burstAdapterImplementation} {PER_BURST_TYPE_CONVERTER}
save_system {system_bd.qsys}
