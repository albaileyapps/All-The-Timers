extends ViewBase

signal add_group(p_group: TimerGroup)

var group = TimerGroup.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass 


func _on_cancel_button_pressed():
	remove_from_parent_view(0.3)


func _on_add_group_button_pressed():
	var new_title: String = $"%TitleLineEdit".text
	if new_title.length() == 0: return
	var seq = %SequentialCheckBox.button_pressed
	group.title = new_title
	group.sequential = seq
	emit_signal("add_group", group)
	remove_from_parent_view(0.3)
	

func _on_title_line_edit_text_changed(new_text):
	$"%AddGroupButton".disabled = !(new_text.length() > 0)


