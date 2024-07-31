extends HBoxContainer

var timer: TimerSimple

# Called when the node enters the scene tree for the first time.
func set_timer(p_timer: TimerSimple):
	timer = p_timer
	timer.changed.connect(_on_timer_changed)
	timer.time_elapsed_changed.connect(_on_timer_time_elapsed_changed)
	_set_labels()

func _on_timer_changed():
	_set_labels()

func _on_timer_time_elapsed_changed():
	_set_labels()

func _set_labels():
	if timer.state == Const.timer_state.STOPPED:
		%MinsLabel.text = str(timer.period.minutes).pad_zeros(2)
		%SecondsLabel.text = str(timer.period.seconds).pad_zeros(2)
	else:
		%MinsLabel.text = str(timer.time_remaining.minutes).pad_zeros(2)
		%SecondsLabel.text = str(timer.time_remaining.seconds).pad_zeros(2)

func _on_mins_inc_button_pressed():
	timer.period.minutes = wrapi(timer.period.minutes + 1, 0, 59)
	_set_labels()
	timer.reset()


func _on_mins_dec_button_pressed():
	timer.period.minutes = wrapi(timer.period.minutes - 1, 0, 59)
	_set_labels()
	timer.reset()
	timer.save()

func _on_seconds_inc_button_2_pressed():
	timer.period.seconds = wrapi(timer.period.seconds + 1, 0, 59)
	_set_labels()
	timer.reset()
	timer.save()

func _on_seconds_dec_button_2_pressed():
	timer.period.seconds = wrapi(timer.period.seconds - 1, 0, 59)
	_set_labels()
	timer.reset()
	timer.save()
