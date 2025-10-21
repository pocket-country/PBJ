extends Node
##
## Top level script.  Currently functioning a 'global space (no autoload)
## Copyright (c) 2025 William Robb
## Licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License 
## (CC BY-NC-SA 4.0)
##

@onready var UI = $UI			#ref to UI which is really display
@onready var GW = $GW			#ref to game world

# this translates maps all the weirdly named variables in game world to metric slots
var metric_var_names: Dictionary[String, String] = {}


func _ready():
	# set up mapping between UI metric display slots, standard names and 
	# idiosyncratic varable names in game world
	for key in UI.status_bar_values.keys():
		metric_var_names[key] = ""
		
	# so this is the 'by hand' part that makes lines things up
	# the only reason to copy the keys first ensure we are getting the 
	# keys based on node names (from UI setup)
	# I admit this is a bit weird.  Could maybe name nodes in code for 
	# a code based single source of truth?  What happens when you code in a fever dream
		metric_var_names["BD"] = "bread"
		metric_var_names["PB"] = "peanut_butter"
		metric_var_names["OM"] = "marmalade"
		metric_var_names["SJ"] = "strawberry"
		metric_var_names["PBS"] = "pb_slices"
		metric_var_names["OMS"] = "marmalade_slices"
		metric_var_names["SJS"] = "strawberry_slices"
		metric_var_names["SWCH"] = "sandwich_count"
		metric_var_names["COIN"] = "coins"
		metric_var_names["DAY"] = "day"
		
	# connect metric updated signal from game world
	var error = GW.a_metric_changed.connect(update_status_bar)
	if error != OK:
		print("Error connecting signal: ", error)
		
	# finally, init the status bar with whatever values we have
	update_status_bar()
	

func update_status_bar():
	# names, common guy! TODO this can now be a loop
	for key in metric_var_names:
		UI.update_metric(key, GW.get(metric_var_names[key]))
	# template === UI.update_metric("PB", peanut_butter)
	
