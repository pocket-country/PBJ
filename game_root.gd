extends Node2D

# supply levels (bread is infinite?!)
var peanut_butter: int
var marmalade: int
var strawberry: int

var coins: int

# hold sandwiches.  We will generalize this later
var sandwiches: Array = []
var sandwich_count: int = 0

# hold current activated slices, one of each kind
var got_pb: Area2D
var got_j: Area2D

func _ready():
	# set values for resources (how big is the jar) used to make new slices
	peanut_butter = 10
	marmalade = 5
	strawberry = 5
	# and if we sell any, well ...
	coins = 0
	
	# Connect to all the slice signals
	for child in get_children():
		# Check if the child is a slice node (e.g., check its group, name, or type)
		if child.is_in_group("Slice"): 
			# Connect the child's signal (e.g., "combined") to a method in THIS root script
			# these lines of code caused heartburn.  Something about strict type checking?...
			#var toast_slice = child.get_node_or_null("Toast") as Area2D
			var error = child.slice_clicked.connect(_on_slice_clicked)
			if error != OK:
				print("Error connecting signal: ", error)
				
	# get references to all the sandwich nodes
	sandwiches = get_tree().get_nodes_in_group("Sandwich")
	for sando in sandwiches:
		sando.visible = false
		
	# init active slices
	got_pb = null
	got_j = null


func _on_slice_clicked(which_slice):
	# Get slice group
	# And see if we've already got a slice of this type
	if which_slice.is_in_group("PeanutButter"):
		if got_pb == null:
			got_pb = which_slice
			got_pb.select()
		else:
			# Did we click on the same slice?  If so who cares.  
			# If not, switch nodes, can only have one activated
			if which_slice != got_pb:
				got_pb.deselect()
				got_pb = which_slice
				got_pb.select()
	else: # jelly slice
		if got_j == null:
			got_j = which_slice
			got_j.select()
		else:
			if which_slice != got_pb:
				got_pb.deselect()
				got_pb = which_slice
				got_pb.select()
	
	# do we have the makings of a sandwich?
	if got_pb != null and got_j != null:
		make_sandwich()


# This function resets the state after the animation/clearance
func make_sandwich():
	var current_sando = sandwiches[sandwich_count]
	current_sando.visible = true
	sandwich_count += 1
	
	# deal with slices, hide them, set active to null etc.
		# TODO that mouse thing?
	got_pb.deselect()
	got_pb.hide()
	got_pb = null
	
	got_j.deselect()
	got_j.hide()
	got_j = null
