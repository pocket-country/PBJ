extends Area2D

func _ready():
	# Connect the input_event signal to a custom function
	input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	# Check if the event is a mouse button event
	if event is InputEventMouseButton:
		# Check if the left mouse button was pressed
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			# Call your custom function when the sprite is clicked
			on_click()

func on_click():
	print("%s clicked!" % [name])
	# Add your click logic here, e.g., play an animation, change a variable, etc.
