extends Resource
class_name TimerSimple

@export var title: String
@export var period: Dictionary = {
	"hours": 0,
	"minutes": 0,
	"seconds": 0
}
@export var index: int
@export var path: String
@export var id: String

var state = Const.timer_state.STOPPED
var time_elapsed = 0
var seconds_elapsed = 0

signal time_elapsed_changed

func _init(p_title: String = "", p_id: String = "", p_path: String = "", p_index: int = 0, p_period: Dictionary = {
	"hours": 0,
	"minutes": 0,
	"seconds": 0
}):
	print("init simple timer")
	title = p_title
	id = p_id
	path = p_path
	period = p_period
	index = p_index


func start():
	state = Const.timer_state.RUNNING
	emit_changed()
	
func pause():
	state = Const.timer_state.PAUSED
	emit_changed()
	
func reset():
	pass
	
func process(delta):

	if state != Const.timer_state.RUNNING: return
	time_elapsed += delta
	if time_elapsed >= 1.0:
		time_elapsed -= 1.0
		seconds_elapsed += 1
		emit_signal("time_elapsed_changed")
	
func save():
	print("saving simple timer")
	var dir_exists = DirAccess.dir_exists_absolute("user://" + path)
	if !dir_exists: DirAccess.make_dir_absolute("user://" + path)
	ResourceSaver.save(self, "user://" + path + "/" + id + ".tres")
