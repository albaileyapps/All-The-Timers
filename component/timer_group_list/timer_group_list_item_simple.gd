extends Control

var timer: Resource

signal timer_simple_pressed(p_timer)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.changed.connect(_build_ui)
	timer.time_elapsed_changed.connect(_on_timer_tick)
	_build_ui()


func _build_ui():
	if timer.state == Const.timer_state.RUNNING:
		_build_ui_running()
	else:
		_build_ui_not_running()
		
func _build_ui_running():
	%RunningHBox.visible = true
	%StoppedHBox.visible = false
	%TimeLabel.text = str(timer.seconds_elapsed)
	
#on the list item, only a start or pause button are shown
func _build_ui_not_running():
	%RunningHBox.visible = false
	%StoppedHBox.visible = true
	if timer.get("title"):
		%TitleLabel.text = timer.title
	
func _build_ui_edit_mode():
	pass
	
func _on_timer_tick():
	%TimeLabel.text = str(timer.seconds_elapsed)


func _on_start_button_pressed():
	timer.start()


func _on_timer_group_list_item_timer_list_item_pressed():
	emit_signal("timer_simple_pressed", timer)


func _on_pause_button_pressed():
	timer.pause()
