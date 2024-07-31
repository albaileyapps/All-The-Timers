extends Control

#var is_edit_mode = false

var timer: TimerSimple

signal timer_simple_pressed(p_timer)
signal timer_simple_delete_pressed(p_timer)
signal timer_simple_options_pressed(p_timer)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.changed.connect(_build_ui)
	timer.time_elapsed_changed.connect(_on_timer_tick)
	_build_ui()


func _build_ui():
	var suffix = ":  " if timer.title.length() > 0 else ""
	%TitleLabel.text = timer.title + suffix
	%IconColor.color_set = timer.color_set
	#if is_edit_mode:
		#_build_ui_edit_mode()
		#return
	%OptionsButton.visible = (timer.state == Const.timer_state.STOPPED)
	%DeleteButton.visible = false
	%StartButton.visible = !(timer.state == Const.timer_state.RUNNING)
	%StopButton.visible = !(timer.state == Const.timer_state.STOPPED)
	%PauseButton.visible = (timer.state == Const.timer_state.RUNNING)
	if timer.state == Const.timer_state.STOPPED:
		_set_time_label_from_dict(timer.period)
	else:
		_set_time_label_from_dict(timer.time_remaining)


	
func _build_ui_edit_mode():
	%StartButton.visible = false
	%StopButton.visible = false
	%PauseButton.visible = false
	%OptionsButton.visible = true
	%DeleteButton.visible = true
	_set_time_label_from_dict(timer.time_remaining) #may need to change how the time label is set here
	
func _set_time_label_from_dict(p_dict: Dictionary):
		#%TimeLabel.text = "%02d:%02d:%02d" % [p_dict.hours, p_dict.minutes, p_dict.seconds]
		%TimeLabel.text = "%02d:%02d" % [p_dict.minutes, p_dict.seconds]
	
func _on_timer_tick():
	var t = timer.time_remaining
	#var s = "%02d:%02d:%02d" % [t.hours, t.minutes, t.seconds]
	var s = "%02d:%02d" % [t.minutes, t.seconds]
	%TimeLabel.text = s


func _on_start_button_pressed():
	timer.start()

func _on_pause_button_pressed():
	timer.pause()
	
func _on_stop_button_pressed():
	timer.stop()
	
func _on_timer_group_list_item_timer_list_item_pressed():
	#if is_edit_mode: return
	emit_signal("timer_simple_pressed", timer)


func _on_delete_button_pressed():
	emit_signal("timer_simple_delete_pressed", timer)


func _on_options_button_pressed():
	emit_signal("timer_simple_options_pressed", timer)

