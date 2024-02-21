extends Control

var is_edit_mode = false

var timer: Resource:
	set(p_val):
		timer = p_val
		_on_timer_set()

signal timer_simple_pressed(p_timer)
signal timer_simple_delete_pressed(p_timer)
signal timer_simple_options_pressed(p_timer)

# Called when the node enters the scene tree for the first time.
func _ready():
	_build_ui()

func _on_timer_set():
	timer.changed.connect(_build_ui)
	timer.time_elapsed_changed.connect(_on_timer_tick)
	_build_ui()

func _build_ui():
	if is_edit_mode:
		_build_ui_edit_mode()
		return
	%TitleLabel.text = timer.title
	var t = timer.time_remaining
	var s = "%02d:%02d:%02d" % [t.hours, t.minutes, t.seconds]
	%TimeLabel.text = s
	if timer.state == Const.timer_state.RUNNING:
		_build_ui_running()
	else:
		_build_ui_not_running()
		
func _build_ui_running():
	%StartButton.visible = false
	%PauseButton.visible = true
	%OptionsButton.visible = false
	%DeleteButton.visible = false
	
#on the list item, only a start or pause button are shown
func _build_ui_not_running():
	%StartButton.visible = true
	%PauseButton.visible = false
	%OptionsButton.visible = false
	%DeleteButton.visible = false
	
func _build_ui_edit_mode():
	%StartButton.visible = false
	%PauseButton.visible = false
	%OptionsButton.visible = true
	%DeleteButton.visible = true
	
func _on_timer_tick():
	var t = timer.time_remaining
	var s = "%02d:%02d:%02d" % [t.hours, t.minutes, t.seconds]
	%TimeLabel.text = s


func _on_start_button_pressed():
	timer.start()


func _on_timer_group_list_item_timer_list_item_pressed():
	emit_signal("timer_simple_pressed", timer)


func _on_pause_button_pressed():
	timer.pause()


func _on_delete_button_pressed():
	emit_signal("timer_simple_delete_pressed", timer)


func _on_options_button_pressed():
	emit_signal("timer_simple_options_pressed", timer)
