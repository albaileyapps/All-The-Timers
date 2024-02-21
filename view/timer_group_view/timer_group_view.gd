extends ViewBase


var timer_group: TimerGroup

var is_edit_mode = false

@onready var navbar = $VBoxContainer/NavBar

# Called when the node enters the scene tree for the first time.
func _ready():
	fadables = [$VBoxContainer]
	navbar.title = timer_group.title
	navbar.exit_pressed.connect(_on_exit_pressed)
	timer_group.changed.connect(_on_timer_group_changed)
	timer_group.load_children()

func _on_timer_group_changed():
	_build_list()

func _build_list():
	$"%TimerGroupList".remove_all()
	for child in timer_group.children:
		if child is TimerGroup:
			var item = load("res://component/timer_group_list/list_item_timer_group.tscn").instantiate()
			item.timer = child
			item.timer_group_pressed.connect(_on_timer_group_pressed)
			item.is_edit_mode = is_edit_mode
			$"%TimerGroupList".add_item(item)
		if child is TimerSimple:
			var item = load("res://component/timer_group_list/list_item_timer_simple.tscn").instantiate()
			item.timer = child
			item.timer_simple_pressed.connect(_on_timer_simple_pressed)
			item.timer_simple_delete_pressed.connect(_on_timer_simple_delete_pressed)
			item.is_edit_mode = is_edit_mode
			$"%TimerGroupList".add_item(item)

	
func _remove_timer():
	pass
	
	
func _on_timer_group_pressed(p_timer: Resource):
	var timer_group_view = load("res://view/timer_group_view/timer_group_view.tscn").instantiate()
	timer_group_view.timer_group = p_timer
	fade(0.0, 0.3, 0.0)
	add_child_view(timer_group_view, 0.3, 0.3)

	timer_group_view.navbar.show_exit_button = true
	timer_group_view.navbar.exit_pressed.connect(_on_child_group_view_exit_pressed)
	
func _on_child_group_view_exit_pressed():
	fade(1.0, 0.3, 0.4)
	
func _on_timer_simple_pressed(p_timer: Resource):
	var timer_simple_view = load("res://view/timer_simple_view/timer_simple_view.tscn").instantiate()
	timer_simple_view.timer = p_timer
	fade(0.0, 0.3, 0.0)
	add_child_view(timer_simple_view, 0.3, 0.3)
	timer_simple_view.navbar.show_exit_button = true
	timer_simple_view.navbar.exit_pressed.connect(_on_child_simple_view_exit_pressed)
	
func _on_timer_simple_delete_pressed(p_timer):
	timer_group.delete_timer_simple(p_timer)
	
func _on_child_simple_view_exit_pressed():
	fade(1.0, 0.3, 0.4)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer_group.process(delta)


func _on_add_timer_button_pressed():
	var view = load("res://view/edit_timer_view/edit_timer_view.tscn").instantiate()
	view.add_timer.connect(_on_add_timer_simple)
	add_child_view(view, 0.3, 0.0)
	
func _on_add_group_button_pressed():
	var view = load("res://view/edit_group_view/edit_group_view.tscn").instantiate()
	view.add_group.connect(_on_add_timer_group)
	add_child_view(view, 0.3, 0.0)
	
func _on_add_timer_simple(p_timer: TimerSimple):
	timer_group.add_timer_simple(p_timer)
	
func _on_add_timer_group(p_group: TimerGroup):
	timer_group.add_timer_group(p_group)
	
func _on_exit_pressed():
	timer_group.unload_children()
	remove_from_parent_view(0.3)


func _on_edit_mode_button_pressed():
	is_edit_mode = !is_edit_mode
	print("toggle edit mode: ", is_edit_mode)
	_build_list()


func _on_options_button_pressed():
	pass # Replace with function body.
