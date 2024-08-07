extends Control

#var is_edit_mode = false

var timer: TimerGroup

signal timer_group_pressed(p_timer)
signal timer_group_delete_pressed(p_timer)
signal timer_group_options_pressed(p_timer)

func _ready():
	timer.changed.connect(_build_ui)
	_build_ui()

func _build_ui():
	%TitleLabel.text = timer.title
	%RightArrow.visible = true
	%DeleteButton.visible = false
	%IconColor.color_set = timer.color_set
		

func _on_timer_group_list_item_timer_list_item_pressed():
	#if is_edit_mode: return
	emit_signal("timer_group_pressed", timer)


func _on_delete_button_pressed():
	emit_signal("timer_group_delete_pressed", timer)


func _on_options_button_pressed():
	emit_signal("timer_group_options_pressed", timer)
