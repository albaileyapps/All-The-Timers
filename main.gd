extends Control

func _init():
	print("main init")
	setup_dir()
# Called when the node enters the scene tree for the first time.
func _ready():
	print("main ready")
	

func setup_dir():
	var dir_exists = DirAccess.dir_exists_absolute(Const.SAVE_TIMERS_DIR)
	if !dir_exists: DirAccess.make_dir_absolute(Const.SAVE_TIMERS_DIR)	
	

