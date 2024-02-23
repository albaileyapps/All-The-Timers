extends Control

var children: Array[ColorButton]

signal color_selected(p_color_set: Dictionary)


func _ready():
	for key in Const.color_sets.keys():
		var color_button = load("res://component/color_button/color_button.tscn").instantiate()
		color_button.color_set = Const.color_sets[key]
		color_button.pressed.connect(_on_color_button_pressed)
		children.append(color_button)
		add_child(color_button)


func set_selected_color(p_color_set: Dictionary):
	for child in children:
		child.set_highlight(p_color_set)
		
func _on_color_button_pressed(p_color_set: Dictionary):
	emit_signal("color_selected", p_color_set)
