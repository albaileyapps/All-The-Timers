extends ViewBase

signal ok_pressed(p_timer: TimerSimple)

var timer: TimerSimple

# Called when the node enters the scene tree for the first time.
func _ready():
	%TimerSetter.timer_simple = timer
	%TitleLineEdit.text = timer.title


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass 


func _on_cancel_button_pressed():
	remove_from_parent_view(0.3)


func _on_title_line_edit_text_changed(new_text):
#	$"%AddTimerButton".disabled = !(new_text.length() > 0)
	pass


func _on_ok_button_pressed():
	var new_title: String = $"%TitleLineEdit".text
	timer.title = new_title
	
	emit_signal("ok_pressed", timer)
	remove_from_parent_view(0.3)
