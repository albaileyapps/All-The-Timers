extends Control

var timer: Resource

signal timer_group_pressed(p_timer)

func _ready():
	timer.changed.connect(_build_ui)
	_build_ui()

func _build_ui():
	if timer.get("title"):
		%TitleLabel.text = timer.title

func _on_timer_group_list_item_timer_list_item_pressed():
	emit_signal("timer_group_pressed", timer)
