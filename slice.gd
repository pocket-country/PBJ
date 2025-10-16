extends Area2D

signal slice_clicked(whoami: Area2D)

# for highlighting slices via shader.  Dude I wrote shader code!
var slice_material = $Toast.material


func _ready():
	# Connect the input_event signal to a custom function
	input_event.connect(_on_input_event)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			on_click()


func on_click():
	print("%s clicked!" % [name])
	# gotta let the controler know that we've been selected
	emit_signal("slice_clicked", self)


func select():
	slice_material.set_shader_parameter("is_highlighted", true)


func deselect():
	slice_material.set_shader_parameter("is_highlighted", false)


func into_sandwich():
	hide()
	# something about keeping it from being able to be clicked on TODO


func regerate():
	show()
	deselect()
	#enable mouse?
	
	# take out of jar to spread on slice
	if is_in_group("PeanutButter"):
		get_tree().get_root().peanut_butter -= 1
	if is_in_group("Marmalade"):
		get_tree().get_root().maralade -= 1
	if is_in_group("Strawberry"):
		get_tree().get_root().strawberry -= 1	
