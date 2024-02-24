extends ViewBase

signal ok_pressed(p_timer: TimerSimple)

var title = "Add a New Timer"
var timer: TimerSimple

# Called when the node enters the scene tree for the first time.
func _ready():
	fadables = [self]
	_build_ui()
	timer.changed.connect(_build_ui)


func _build_ui():
	%Label.text = title
	%TimerSetter.timer_simple = timer
	%TitleLineEdit.text = timer.title
	%ColorPicker.set_selected_color(timer.color_set)

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


func _on_panel_container_focus_entered():
	print("panel focus entered")


func _on_color_picker_color_selected(p_color_set):
	timer.color_set = p_color_set
