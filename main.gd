extends Control

func _init():
	pass

func _ready():
	set_margins()
	
	#BkgEventBus singleton is used to set the bkg colors from anywhere
	BkgEventBus.set_bkg_color.connect(_set_bkg_colors)
	
	#the home view is loaded with a default TimerGroup
	var res = load("res://resource/root_timer_group.tres")
	var timer_group_view = load("res://view/timer_group_view/timer_group_view.tscn").instantiate()
	timer_group_view.timer_group = res
	#hide the options button as the default group cannot be edited
	timer_group_view.show_options_button = false
	$MarginContainer.add_child(timer_group_view)


	
func _set_bkg_colors(p_dict: Dictionary):
	#should check that p_dict contains "top" and "botton" keys with valid color values
	var dur = 0.6
	var tween = create_tween()
	tween.parallel().tween_property($Bkg.get_material(), "shader_parameter/top", Color(p_dict.top), dur)
	tween.parallel().tween_property($Bkg.get_material(), "shader_parameter/bottom", Color(p_dict.bottom), dur)
	
	
func set_margins():
	### TAKE CARE OF NOTCHES AND SUCH
	if OS.get_name() != "iOS" and OS.get_name() != "Android": return
	var safe_area  = DisplayServer.get_display_safe_area()
	var window_size = DisplayServer.screen_get_size()

	var y_scale = size.y / window_size.y
	var x_scale = size.x / window_size.x
	
	var top= safe_area.position.y * y_scale
	var left = safe_area.position.x * x_scale
	var bottom = (window_size.y - safe_area.size.y - safe_area.position.y) * y_scale
	var right = (window_size.x - safe_area.size.x - safe_area.position.x) * x_scale
	
	$MarginContainer.add_theme_constant_override("margin_top",top)
	$MarginContainer.add_theme_constant_override("margin_left",0)
	$MarginContainer.add_theme_constant_override("margin_right",0)
	$MarginContainer.add_theme_constant_override("margin_bottom",bottom)

	
