extends Control
class_name  ColorButton

var color_set: Dictionary

signal pressed(p_dict: Dictionary)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("color button ready: ", color_set)
	$TextureButton.get_material().set_shader_parameter("top", Color(color_set["top"]))
	$TextureButton.get_material().set_shader_parameter("bottom", Color(color_set["bottom"]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	emit_signal("pressed", color_set)
	
func set_highlight(p_dict: Dictionary):
	print("setting highlight on color button")
	if color_set.top == p_dict.top and color_set.bottom == p_dict.bottom:
		$Highlight.visible = true
	else:
		$Highlight.visible = false
