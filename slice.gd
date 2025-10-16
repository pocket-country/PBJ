extends Area2D

signal slice_clicked(slice_name: String, selected: bool)


var selected: bool


func _ready():
	# Connect the input_event signal to a custom function
	input_event.connect(_on_input_event)
	selected = false

func _on_input_event(viewport, event, shape_idx):
	# Check if the event is a mouse button event
	if event is InputEventMouseButton:
		# Check if the left mouse button was pressed
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			# Call your custom function when the sprite is clicked
			on_click()

func on_click():
	print("%s clicked!" % [name])
	if selected:
		selected = false
	else:
		selected = true
	# gotta let the controler know that we've been selected
	emit_signal("slice_clicked", name, selected)

func into_sandwich():
	hide()

func regerate():
	show()
	if is_in_group("PeanutButter"):
		get_tree().get_root().peanut_butter -= 1
	if is_in_group("Marmalade"):
		get_tree().get_root().maralade -= 1
	if is_in_group("Strawberry"):
		get_tree().get_root().strawberry -= 1	
		
		
	
