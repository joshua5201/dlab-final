
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name final -dir "D:/final0310015/planAhead_run_2" -part xc3s500efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/final0310015/final.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/final0310015} }
set_property target_constrs_file "final.ucf" [current_fileset -constrset]
add_files [list {final.ucf}] -fileset [get_property constrset [current_run]]
link_design
