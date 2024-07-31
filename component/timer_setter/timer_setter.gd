extends Control

var timer_simple: TimerSimple:
	set(p_timer):
		timer_simple = p_timer
		_set_values(p_timer.period)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _set_values(p_period):
	%HourStepper.set_value(p_period.hours)
	%MinuteStepper.set_value(p_period.minutes)
	%SecondStepper.set_value(p_period.seconds)

func _on_hour_stepper_up_pressed():
	timer_simple.period.hours = wrapi(timer_simple.period.hours + 1, 0, 59)
	timer_simple.save()
	_set_values(timer_simple.period)

func _on_hour_stepper_down_pressed():
	timer_simple.period.hours = wrapi(timer_simple.period.hours - 1, 0, 59)
	timer_simple.save()
	_set_values(timer_simple.period)

func _on_minute_stepper_up_pressed():
	timer_simple.period.minutes = wrapi(timer_simple.period.minutes + 1, 0, 59)
	timer_simple.save()
	_set_values(timer_simple.period)

func _on_minute_stepper_down_pressed():
	timer_simple.period.minutes = wrapi(timer_simple.period.minutes - 1, 0, 59)
	timer_simple.save()
	_set_values(timer_simple.period)

func _on_second_stepper_up_pressed():
	timer_simple.period.seconds = wrapi(timer_simple.period.seconds + 1, 0, 59)
	timer_simple.save()
	_set_values(timer_simple.period)

func _on_second_stepper_down_pressed():
	timer_simple.period.seconds = wrapi(timer_simple.period.seconds - 1, 0, 59)
	timer_simple.save()
	_set_values(timer_simple.period)


func _on_hour_stepper_text_changed(p_text: String):
	timer_simple.period.hours = clamp(int(p_text), 0, 99)
	#_set_values(timer_simple.period)


func _on_minute_stepper_text_changed(p_text: String):
	timer_simple.period.minutes = clamp(int(p_text), 0, 59)
	#_set_values(timer_simple.period)


func _on_second_stepper_text_changed(p_text: String):
	timer_simple.period.seconds = clamp(int(p_text), 0, 59)
	#_set_values(timer_simple.period)
