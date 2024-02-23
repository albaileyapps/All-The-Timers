extends ViewBase

signal ok_pressed(p_group: TimerGroup)

var group: TimerGroup
var title = "Add a New Timer Group"

# Called when the node enters the scene tree for the first time.
func _ready():
	fadables = [self]
	%Label.text = title
	%TitleLineEdit.text = group.title


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass 


func _on_cancel_button_pressed():
	remove_from_parent_view(0.3)

func _on_ok_button_pressed():
	var new_title: String = $"%TitleLineEdit".text
	if new_title.length() == 0: return
	var seq = %SequentialCheckBox.button_pressed
	group.title = new_title
	group.sequential = seq
	emit_signal("ok_pressed", group)
	remove_from_parent_view(0.3)
	

func _on_title_line_edit_text_changed(new_text):
	$"%OkButton".disabled = !(new_text.length() > 0)


