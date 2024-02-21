extends ViewBase

signal add_timer(p_timer: TimerSimple)

var timer = TimerSimple.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass 


func _on_cancel_button_pressed():
	remove_from_parent_view(0.3)


func _on_add_timer_button_pressed():
	var new_title: String = $"%TitleLineEdit".text
#	if new_title.length() == 0: return
	var new_period = {"hours": %HourSpinBox.value, "minutes": %MinuteSpinBox.value, "seconds": %SecondSpinBox.value}
	timer.title = new_title
	timer.period  = new_period
	
	emit_signal("add_timer", timer)
	remove_from_parent_view(0.3)
	

func _on_title_line_edit_text_changed(new_text):
#	$"%AddTimerButton".disabled = !(new_text.length() > 0)
	pass
