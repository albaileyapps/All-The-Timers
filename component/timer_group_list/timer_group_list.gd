extends ScrollContainer

var list_items: Array = []
const  spacing = 20

var is_dragging = false
var current_drag_index: int
var drag_item: Control
var empty_position: Vector2

func add_item(p_item):
	%ListContainer.add_child(p_item)
	list_items.append(p_item)

	
func remove_all():
	for child in %ListContainer.get_children():
		child.queue_free()
	list_items = []
