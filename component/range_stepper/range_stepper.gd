extends Control

@export var range_min = 0
@export var range_max = 59

var labels: Array[Label] = []

signal up_pressed
signal down_pressed
signal text_changed(p_text)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_value(p_val: int):
	%Label.text = "%02d" % [clamp(p_val, range_min, range_max)]
	

func _on_up_button_pressed():
	emit_signal("up_pressed")

func _on_down_button_pressed():
	emit_signal("down_pressed")
	
func _on_label_text_changed(new_text):
	emit_signal("text_changed", new_text)
