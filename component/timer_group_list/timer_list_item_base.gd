extends PanelContainer
class_name TimerListItem

var touch_down_time: int
var touch_down_pos: Vector2


signal timer_list_item_pressed()

func _ready():
	pass



func _on_gui_input(event):

	if !event is InputEventMouseButton: return
	if event.button_index != MOUSE_BUTTON_LEFT: return
	if event.pressed:
		modulate.a = 0.5
		touch_down_time = Time.get_ticks_msec()
		touch_down_pos = get_global_mouse_position()
	else:
		modulate.a = 1.0
		if Time.get_ticks_msec() - touch_down_time > 800: return
		if touch_down_pos.distance_to(get_global_mouse_position()) > 10: return
		emit_signal("timer_list_item_pressed")
