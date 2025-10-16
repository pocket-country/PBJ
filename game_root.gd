extends Node2D

# supply levels (bread is infinite?!)
var peanut_butter: int
var marmalade: int
var strawberry: int

var coins: int

# hold sandwiches.  We will generalize this later
var sandwiches: Array = []
var sandwich_count: int = 0

# Slice State Constants for control FSA
const STATE_NONE = 0
const STATE_PB = 1
const STATE_J = 2
const STATE_PB_AND_J = 3

var current_state = STATE_NONE # Initialize the machine


func _ready():
	# set values for resources
	peanut_butter = 10
	marmalade = 5
	strawberry = 5
	coins = 0
	
# Connect to all the slice signals
	for child in get_children():
		# Check if the child is a slice node (e.g., check its group, name, or type)
		if child.is_in_group("slices"): 
			# Connect the child's signal (e.g., "combined") to a method in THIS root script
			var error = child.slice_clicked.connect(_on_slice_click)
			if error != OK:
				print("Error connecting signal: ", error)
				
	# get references to all the sandwich nodes
	sandwiches = get_tree().get_nodes_in_group("Sandwiches")
	for sando in sandwiches:
		sando.visible = false


func _on_slice_click(slice_name: String, slice_selected: bool):
	# get slice group
	var slice_type:String = "placeholder"
	# call to process slice
	process_slice_click(slice_type, slice_selected)


# This function is called by the root node when a slice signal is received
func process_slice_click(slice_type: String, selected: bool):
	# Outer Match: Selects based on the CURRENT STATE
	match current_state:
		STATE_NONE:
			# can't have unselected as nothing is slected?!
			if selected:
				if slice_type == "PeanutButter":
					current_state = STATE_PB
				# Action: Highlight the PB slice
				if (slice_type == "Marmalade" or slice_type == "strawberry"):
					current_state = STATE_J
					# Action: Highlight the PB slice
		STATE_J:
			# Only accept the opposite slice type to complete the set
			if slice_type == "PeanutButter" and selected:
				current_state = STATE_PB_AND_J
				# Action: Trigger the slap animation, play sound, update score, start timer
			if (slice_type == "Marmalade" or slice_type == "Strawberry") and not selected:
				# don't have pb or it would be BOTH.  So retreat to none
				current_state = STATE_NONE
		STATE_PB:
			# Only accept the opposite slice type to complete the set
			if slice_type ==  "Marmalade" or slice_type == "Strawberry" and selected:
				current_state = STATE_PB_AND_J
				# Action: Trigger the slap animation, play sound, update score, start timer
			if (slice_type == "PeanutButter") and not selected:
				#  retreat to none
				current_state = STATE_NONE
				# Action: Trigger the slap animation, play sound, update score, start timer
		STATE_PB_AND_J:
			current_state = STATE_NONE
			# Action: Ignore all clicks while the sandwich process is finishing
			make_sandwich()



# This function resets the state after the animation/clearance
func make_sandwich():
	var current_sando = sandwiches[sandwich_count]
	current_sando.visible = true
	sandwich_count += 1
	
	
	
