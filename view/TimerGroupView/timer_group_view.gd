extends ViewBase

var timers = []
@export var timer_group: TimerGroup
@export var title: String

@onready var navbar = $VBoxContainer/NavBar

# Called when the node enters the scene tree for the first time.
func _ready():
	fadables = [$VBoxContainer]
	$"%NavBar".title = title
	timer_group.changed.connect(_on_timer_group_changed)
	timer_group.load_children()

func _on_timer_group_changed():
	_build_list()

func _build_list():
	$"%TimerGroupList".remove_all()
	for child in timer_group.children:
		if child is TimerGroup:
			var item = load("res://component/timer_group_list/timer_list_item_group.tscn").instantiate()
			item.timer = child
			item.timer_group_pressed.connect(_on_timer_group_pressed)
			$"%TimerGroupList".add_item(item)
		if child is TimerSimple:
			var item = load("res://component/timer_group_list/timer_group_list_item_simple.tscn").instantiate()
			item.timer = child
			$"%TimerGroupList".add_item(item)

	
func _remove_timer():
	pass
	
	
func _on_timer_group_pressed(p_timer: Resource):
	var timer_group_view = load("res://view/TimerGroupView/timer_group_view.tscn").instantiate()
	timer_group_view.timer_group = p_timer
	timer_group_view.title = p_timer.title
	fade(0.0, 0.3, 0.0)
	add_child_view(timer_group_view, 0.3, 0.3)
	timer_group_view.navbar.show_exit_button = true
	
func _on_timer_simple_pressed(p_timer: Resource):
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer_group.process(delta)


func _on_add_timer_button_pressed():
	var view = load("res://view/AddTimerView/add_timer_view.tscn").instantiate()
	view.add_timer.connect(_on_add_timer)
	add_child_view(view, 0.3, 0.0)
	
func _on_add_timer(p_title: String, p_period: Dictionary, p_is_group: bool):
	if p_is_group:
		_add_timer_group(p_title)
	else: 
		_add_timer_simple(p_title, p_period)

func _add_timer_group(p_title: String):
	timer_group.add_timer_group(p_title)

func _add_timer_simple(p_title: String, p_period: Dictionary):
	timer_group.add_timer_simple(p_title, p_period)
	
