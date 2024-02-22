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
	match timer.state:
		Const.timer_state.RUNNING:
			_build_ui_running()
		Const.timer_state.PAUSED:
			_build_ui_paused()
		Const.timer_state.STOPPED:
			_build_ui_stopped()
		
func _build_ui_running():
	%StartButton.visible = false
	%StopButton.visible = true
	%PauseButton.visible = true
	%OptionsButton.visible = false
	%DeleteButton.visible = false
	_set_time_label_from_dict(timer.time_remaining)
	
#on the list item, only a start or pause button are shown
func _build_ui_stopped():
	%StartButton.visible = true
	%StopButton.visible = false
	%PauseButton.visible = false
	%OptionsButton.visible = false
	%DeleteButton.visible = false
	_set_time_label_from_dict(timer.period)
	
func _build_ui_paused():
	%StartButton.visible = true
	%StopButton.visible = true
	%PauseButton.visible = false
	%OptionsButton.visible = false
	%DeleteButton.visible = false
	_set_time_label_from_dict(timer.time_remaining)
	
func _build_ui_edit_mode():
	%StartButton.visible = false
	%PauseButton.visible = false
	%OptionsButton.visible = true
	%DeleteButton.visible = true
	
func _set_time_label_from_dict(p_dict: Dictionary):
	#if p_dict.hours == 0:
		#%TimeLabel.text = "%02d:%02d" % [p_dict.minutes, p_dict.seconds]
	#else:
		%TimeLabel.text = "%02d:%02d:%02d" % [p_dict.hours, p_dict.minutes, p_dict.seconds]
	
func _on_timer_tick():
	var t = timer.time_remaining
	var s = "%02d:%02d:%02d" % [t.hours, t.minutes, t.seconds]
	%TimeLabel.text = s


func _on_start_button_pressed():
	timer.start()

func _on_pause_button_pressed():
	timer.pause()
	
func _on_stop_button_pressed():
	timer.stop()
	
func _on_timer_group_list_item_timer_list_item_pressed():
	if is_edit_mode: return
	emit_signal("timer_simple_pressed", timer)


func _on_delete_button_pressed():
	emit_signal("timer_simple_delete_pressed", timer)


func _on_options_button_pressed():
	emit_signal("timer_simple_options_pressed", timer)

