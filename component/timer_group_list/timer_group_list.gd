extends ScrollContainer

var list_items: Array = []
const  spacing = 20

var is_dragging = false
var current_drag_index: int
var drag_item: Control
var empty_position: Vector2

func add_item(p_item):
	print("adding a list item to the list")
#	var y_pos = 0
#	if list_items.size() > 0:
#		y_pos += list_items[list_items.size() - 1].get_rect().position.y
#		y_pos += list_items[list_items.size() - 1].get_rect().size.y
#		y_pos += spacing
#	p_item.position = Vector2(0, y_pos)
	%ListContainer.add_child(p_item)
	list_items.append(p_item)
	print("children of list: ", %ListContainer.get_children().size())
#	calculate_size()
	
func remove_all():
	for child in %ListContainer.get_children():
		child.queue_free()
	list_items = []
		
#func reorder_items():
#
#	var y_pos = 0
#	list_items.sort_custom(func(a, b): return a.position.y < b.position.y)
#	for i in list_items.size():
#		if i > 0:
#			y_pos += list_items[i - 1].get_global_rect().size.y
#			y_pos += spacing
#		list_items[i].player.index = i
#		if list_items[i] != drag_item:
#			list_items[i].tween_position(Vector2(0, y_pos))
#	emit_signal("reordered")



#Need to call this to make scroll work properly - the ListContainer size has to be set manually to the accumulated size of its children
#func calculate_size():
#	%ListContainer.set_custom_minimum_size(Vector2(0, 0))
#	var height = 0
#	for item in list_items:
#		height = height + item.get_rect().size.y
#		height = height + spacing
#	print("setting container size: ", height)
#	%ListContainer.set_custom_minimum_size(Vector2(0, height))

#func _process(delta):
#	if !is_dragging: return
#	if drag_item == null: return
#	drag_item.position.y = $ListContainer.get_local_mouse_position().y - 30
#	var screen_touch_y = get_local_mouse_position().y
#	if screen_touch_y < 200:
#		scroll_vertical -= 10
#	if screen_touch_y > get_rect().size.y - 200: 
#		scroll_vertical += 10

#func _input(event):
#
#	if event is InputEventMouseMotion:
#		if !is_dragging: return
#		reorder_items()
#
#	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
#		if event.pressed:
#			get_drag_item()
#		else: 
#			drop_item()

#func get_drag_item():
#	for item in list_items:
#		if item.drag_handle_contains_mouse():
#			is_dragging = true
#			drag_item = item
#			current_drag_index = item.player.index
#			empty_position = item.position
#			drag_item.z_index = 20
#			set_auto_scroll(false)

#func drop_item():
#	if !is_dragging: return
#	is_dragging = false
#	drag_item.z_index = 0
#	drag_item = null
#	reorder_items()
		
		
#func set_auto_scroll(val: bool):
##	pass
#	mouse_filter = Control.MOUSE_FILTER_PASS if val else Control.MOUSE_FILTER_IGNORE
##	vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO if val else ScrollContainer.SCROLL_MODE_DISABLED

#func _on_list_container_gui_input(event):
#	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
#		if !event.pressed:
#			set_auto_scroll(true)
