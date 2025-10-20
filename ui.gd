extends Control
##
## Top level UI script
##

var status_bar_values: Dictionary[String, Label] = {}

const METRIC_LABEL = "VBoxContainer/MName"
const METRIC_VALUE = "VBoxContainer/MValue"

func _ready():
	var status_bar_root = $VBoxContainer/Display/HBoxContainer
	# set metric lables and set up array pointing to value nodes	
	for child in status_bar_root.get_children():
		var metric_name = child.name
		child.get_node(METRIC_LABEL).text = metric_name
		var value_node = child.get_node(METRIC_VALUE)
		print(value_node.name)
		status_bar_values[metric_name] = value_node

func update_metric(metric: String, value: int):
	print(metric)
	status_bar_values[metric].text = str(value)	
