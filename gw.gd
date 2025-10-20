extends Node2D
##
## Top Level Game World script.  Control game play, all display nodes etc.
##

# emit when any variable representing a metric in the status bar changes
# list of these can be found in game root _ready() code.
signal metric_changed


var game_root			# reference to our pseudo-autoload holding globals

# all our working variables.  Correspondence to metrics handled in game root
# note: all these variables correspond to metrics displayed on the status bar
# we will rationalize nameing later ... 
# and 'balance' later
# 1) four supply levels (unknown units)
var bread: int = 99					# maybe make 99 a sentinal for infinite?
var peanut_butter: int = 20;		#
var marmalade: int = 10				# assumed to be orange marmalade
var strawberry: int = 10			# assumed to be strawberry jam, not jelly!

# 2) three intermediate product (slices) counts - number of object in game
var pb_slices: int = 0
var marmalade_slices: int = 0
var strawberry_slices: int = 0

# 3) two final outputs 
var sandwich_count: int = 0			# number of objects in game controled by game world
var coins: int = 0					# no sales dynamic yet, placeholder

# 4) day counter
var day: int = 1					# currently placeholder

# hold sandwiches.  We will generalize this later
var sandwiches: Array = []
var sandwich_scene: PackedScene
var sandwiches_are_at: Vector2

# hold current activated slices, one of each kind
var got_pb: Area2D
var got_j: Area2D

func _ready():
	# get ref to game root so can access global values easily
	game_root = owner
		
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
				
	# setup for making sandwiches
	sandwiches_are_at = get_node("SandHere").position
	sandwich_scene = load("res://Sandwich.tscn")
		
	# count statically placed slices
	pb_slices = count_two_groups("PeanutButter", "Slice")
	marmalade_slices = count_two_groups("Marmalade", "Slice")
	strawberry_slices = count_two_groups("Strawberry", "Slice")
	
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


# Instantiate a sandwich scene etc.
func make_sandwich():
	var current_sando = 
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

# helper function to for now count and later maybe return a list
# of nodes in two groups - ie pb & slice or marmalade and sandwich
func count_two_groups(group_a: String, group_b: String):
	var both_nodes = []
	var group_a_nodes = get_tree().get_nodes_in_group(group_a)
	
	for node in group_a_nodes:
		if node.is_in_group(group_b):
			both_nodes.append(node)
			
	return both_nodes.size()
	
	
