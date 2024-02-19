extends ViewBase

signal add_timer(title: String, period: Dictionary, is_group: bool)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass 


func _on_cancel_button_pressed():
	remove_from_parent_view(0.3)


func _on_add_timer_button_pressed():
	var title: String = $"%TitleLineEdit".text
	if title.length() == 0: return
	if $"%TimerTypeGroupButton".button_pressed: 
		emit_signal("add_timer", title, true)
	if $"%TimerTypeSimpleButton".button_pressed:
		var dict = {"hours": %HourSpinBox.value, "miutes": %MinuteSpinBox.value, "seconds": %SecondSpinBox.value}
		emit_signal("add_timer", title, dict, false)
	remove_from_parent_view(0.3)
	

func _on_title_line_edit_text_changed(new_text):
	$"%AddTimerButton".disabled = !(new_text.length() > 0)


func _on_timer_type_simple_button_toggled(button_pressed):
	$PanelContainer/MarginContainer/VBoxContainer/TimerSimpleSetupHBox.visible = button_pressed
