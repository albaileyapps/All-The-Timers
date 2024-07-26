extends TextureRect

var color_set: Dictionary:
	set(p_dict):
		color_set = p_dict
		set_colors(color_set)


func set_colors(p_dict: Dictionary):
	get_material().set_shader_parameter("top", Color(p_dict["top"]))
	get_material().set_shader_parameter("bottom", Color(p_dict["bottom"]))
