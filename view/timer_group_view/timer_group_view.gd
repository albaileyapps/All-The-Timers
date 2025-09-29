extends ViewBase


var timer_group: TimerGroup
var timer_simple_view_is_shown = false

@onready var navbar = $VBoxContainer/NavBar

# Called when the node enters the scene tree for the first time.
func _ready():
	fadables = [$VBoxContainer]
	navbar.exit_pressed.connect(_on_exit_pressed)
	timer_group.changed.connect(_on_timer_group_changed)
	timer_group.start_next_in_sequence.connect(_on_timer_group_next_in_sequence)
	timer_group.sequence_complete.connect(_on_timer_group_sequence_complete)
	timer_group.load_children()
	_build_ui()

func _on_timer_group_changed():
	_build_ui()

func _build_ui():
	navbar.title = timer_group.title
	BkgEventBus.emit_signal("set_bkg_color", timer_group.color_set)
	
	$"%TimerGroupList".remove_all()
	for child in timer_group.children:
		if child is TimerGroup:
			var item = load("res://component/timer_group_list/list_item_timer_group.tscn").instantiate()
			item.timer = child
			item.timer_group_pressed.connect(_on_timer_group_list_item_pressed)
			item.timer_group_options_pressed.connect(_on_timer_group_list_item_options_pressed)
			$"%TimerGroupList".add_item(item)
		if child is TimerSimple:
			var item = load("res://component/timer_group_list/list_item_timer_simple.tscn").instantiate()
			item.timer = child
			item.timer_simple_pressed.connect(_show_timer_simple_view)
			item.timer_simple_options_pressed.connect(_on_timer_simple_list_item_options_pressed)
			$"%TimerGroupList".add_item(item)
	
func _on_timer_group_list_item_pressed(p_timer: Resource):
	var timer_group_view = load("res://view/timer_group_view/timer_group_view.tscn").instantiate()
	timer_group_view.timer_group = p_timer
	fade(0.0, 0.3, 0.0)
	add_child_view(timer_group_view, 0.3, 0.3)
	timer_group_view.navbar.show_exit_button = true
	timer_group_view.navbar.exit_pressed.connect(_on_child_group_view_exit_pressed)
	
func _on_child_group_view_exit_pressed():
	fade(1.0, 0.3, 0.3)
	_build_ui()
	
func _on_timer_group_list_item_options_pressed(p_timer_group: TimerGroup):
	var view = load("res://view/edit_timer_group_view/edit_timer_group_view.tscn").instantiate()
	view.group = p_timer_group
	view.title = "Edit Timer Group"
	view.ok_pressed.connect(_on_timer_group_edited)
	view.delete_pressed.connect(_on_timer_group_edit_view_delete_pressed)
	fade(0.0, 0.3, 0.0)
	add_child_view(view, 0.3, 0.3)
	
func _show_timer_simple_view(p_timer: TimerSimple):
	var timer_simple_view = load("res://view/timer_simple_view/timer_simple_view.tscn").instantiate()
	timer_simple_view.timer = p_timer
	timer_simple_view.next_timer = timer_group.next_timer(p_timer)
	timer_simple_view.previous_timer = timer_group.previous_timer(p_timer)
	timer_simple_view.timer_complete.connect(_on_timer_simple_complete)
	timer_simple_view.next_pressed.connect(_on_timer_simple_view_next_pressed)
	timer_simple_view.previous_pressed.connect(_on_timer_simple_view_delete_pressed)
	fade(0.0, 0.3, 0.0)
	add_child_view(timer_simple_view, 0.3, 0.3)
	timer_simple_view_is_shown = true
	timer_simple_view.navbar.show_exit_button = true
	timer_simple_view.navbar.exit_pressed.connect(_on_child_simple_view_exit_pressed)
	
func _on_child_simple_view_exit_pressed():
	fade(1.0, 0.3, 0.3)
	timer_simple_view_is_shown = false
	_build_ui()
	
func _on_timer_simple_view_next_pressed(p_next_timer: TimerSimple):
	if !p_next_timer: return
	_show_timer_simple_view(p_next_timer)
	
func _on_timer_simple_view_delete_pressed(p_previous_timer: TimerSimple):
	if !p_previous_timer: return
	_show_timer_simple_view(p_previous_timer)
	
#if a TimerSimple Finished and its parent group is sequential, the timer_simple_view must be removed
#and replaced with a new view with the next timer in the sequence
#this is connected to the timer_complete signal of the view instead of the timer itself
#because the timer can run without a view being loaded
func _on_timer_simple_complete(p_view: ViewBase):
	if !timer_group.sequential: return
	p_view.remove_from_parent_view(0.3)
	#timer_simple_view_is_shown = false
	
func _on_timer_group_next_in_sequence(p_timer: TimerSimple):
	if !timer_simple_view_is_shown: return
	var timer_simple_view = load("res://view/timer_simple_view/timer_simple_view.tscn").instantiate()
	timer_simple_view.timer = p_timer
	timer_simple_view.timer_complete.connect(_on_timer_simple_complete)
	fade(0.0, 0.3, 0.0)
	add_child_view(timer_simple_view, 0.3, 0.3)
	timer_simple_view_is_shown = true
	timer_simple_view.navbar.show_exit_button = true
	timer_simple_view.navbar.exit_pressed.connect(_on_child_simple_view_exit_pressed)
	
func _on_timer_group_sequence_complete():
	fade(1.0, 0.3, 0.3)
	timer_simple_view_is_shown = false
	_build_ui()
	
func _on_timer_simple_list_item_delete_pressed(p_timer: TimerSimple):
	timer_group.delete_timer_simple(p_timer)
	fade(1.0, 0.3, 0.3)
	
func _on_timer_simple_list_item_options_pressed(p_timer: TimerSimple):
	var view = load("res://view/edit_timer_simple_view/edit_timer_simple_view.tscn").instantiate()
	view.timer = p_timer
	view.title = "Edit Timer"
	view.ok_pressed.connect(_on_timer_simple_edited)
	view.delete_pressed.connect(_on_timer_simple_edit_view_delete_pressed)
	fade(0.0, 0.3, 0.0)
	add_child_view(view, 0.3, 0.3)
	
func _on_timer_simple_edited(p_timer: TimerSimple):
	p_timer.reset() #hack to set the time remaining (which is displayed) to the period
	p_timer.save()
	p_timer.emit_changed()
	fade(1.0, 0.3, 0.3)
	#timer_group.emit_changed()

func _on_add_timer_button_pressed():
	var view = load("res://view/edit_timer_simple_view/edit_timer_simple_view.tscn").instantiate()
	view.timer = TimerSimple.new()
	view.ok_pressed.connect(_on_timer_simple_edit_view_ok_pressed)
	view.delete_pressed.connect(_on_timer_simple_edit_view_delete_pressed)
	add_child_view(view, 0.3, 0.3)
	fade(0.0, 0.3, 0.0)
	
func _on_timer_simple_edit_view_ok_pressed(p_timer: TimerSimple):
	p_timer.reset() #hack to set the time remaining (which is displayed) to the period
	timer_group.add_timer_simple(p_timer)
	fade(1.0, 0.3, 0.3)
	
func _on_timer_simple_edit_view_delete_pressed(p_timer):
	print("delete timer")
	timer_group.delete_timer_simple(p_timer)
	fade(1.0, 0.3, 0.3)
	
func _on_add_group_button_pressed():
	var view = load("res://view/edit_timer_group_view/edit_timer_group_view.tscn").instantiate()
	view.group = TimerGroup.new()
	view.ok_pressed.connect(_on_timer_group_edit_view_ok_pressed)
	view.delete_pressed.connect(_on_timer_group_edit_view_delete_pressed)
	add_child_view(view, 0.3, 0.3)
	fade(0.0, 0.3, 0.0)

func _on_timer_group_edit_view_ok_pressed(p_group: TimerGroup):
	timer_group.add_timer_group(p_group)
	fade(1.0, 0.3, 0.3)
	
func _on_timer_group_edit_view_delete_pressed(p_group: TimerGroup):
	timer_group.delete_timer_group(p_group)
	fade(1.0, 0.3, 0.3)
	
func _on_exit_pressed():
	timer_group.unload_children()
	remove_from_parent_view(0.3)

func _on_timer_group_edited(p_timer: TimerGroup):
	p_timer.save()
	p_timer.emit_changed()
	fade(1.0, 0.3, 0.3)
	
func _process(delta):
	timer_group.process(delta)
