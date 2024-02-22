extends Control

func _init():
	pass

func _ready():
	set_margins()
	var res = load("res://resource/root_timer_group.tres")
	var timer_group_view = load("res://view/timer_group_view/timer_group_view.tscn").instantiate()
	timer_group_view.timer_group = res
	$MarginContainer.add_child(timer_group_view)
	
func set_margins():
	### TAKE CARE OF NOTCHES AND SUCH
	if OS.get_name() != "iOS" and OS.get_name() != "Android": return
	var safe_area  = DisplayServer.get_display_safe_area()
	var window_size = DisplayServer.screen_get_size()

	var y_scale = size.y / window_size.y
	var x_scale = size.x / window_size.x
	
# SET BASE MARGINS (THE ONES YOU HAVE CURRENTLY IN YOUR MARGIN CONTAINER
	var top= safe_area.position.y * y_scale
	var left = safe_area.position.x * x_scale
	var bottom = (window_size.y - safe_area.size.y - safe_area.position.y) * y_scale
	var right = (window_size.x - safe_area.size.x - safe_area.position.x) * x_scale
	
	
# OVERRIDE MARGIN CONTAINER (HOSTS THIS SCRIPT)
	$MarginContainer.add_theme_constant_override("margin_top",top)
	$MarginContainer.add_theme_constant_override("margin_left",0)
	$MarginContainer.add_theme_constant_override("margin_right",0)
	$MarginContainer.add_theme_constant_override("margin_bottom",bottom)

	
