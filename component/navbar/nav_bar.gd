extends Control

@export var show_exit_button = false:
	set(p_val): 
		show_exit_button = p_val
		$"%ExitButton".visible = show_exit_button

var title: String:
	set(p_val):
		$"%TitleLabel".text = p_val

# Called when the node enters the scene tree for the first time.
func _ready():
	$"%ExitButton".visible = show_exit_button


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
