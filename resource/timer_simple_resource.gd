extends Resource
class_name TimerSimple

@export var title: String
@export var period: Dictionary = {
	"hours": 0,
	"minutes": 0,
	"seconds": 0
}: 
	set(p_dict):
		period = p_dict
		time_remaining = period.duplicate()
	
@export var index: int
@export var path: String
@export var id: String

var state = Const.timer_state.STOPPED
var time_remaining: Dictionary
var time_elapsed = 0
var current_second = 0

#how many seconds before finishing to play a warning sound
var warning_ticks = 5

signal time_elapsed_changed
signal complete(p_timer: TimerSimple)
signal warning_tick

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
	_decrement_seconds()
	emit_changed()
	
func pause():
	state = Const.timer_state.PAUSED
	emit_changed()
	
func stop():
	reset()
	state = Const.timer_state.STOPPED
	emit_changed()
	
func reset():
	time_remaining = period.duplicate()
	time_elapsed = 0
	current_second = 0
	
func process(delta):

	if state != Const.timer_state.RUNNING: return
	time_elapsed += delta
	current_second += delta
	if current_second >= 1.0:
		current_second -= 1.0
		_decrement_seconds()
		emit_signal("time_elapsed_changed")
		
func _decrement_seconds():
	time_remaining["seconds"] -= 1
	_check_warning_tick()
	if time_remaining["seconds"] < 0:
		if _check_timer_complete():
			emit_signal("complete", self)
			SoundManager.play_alert_snd()
			print("finished at time: ", time_elapsed)
			stop()
			return
		_decrement_minutes()
		time_remaining["seconds"] = 59
		
		
func _decrement_minutes():
	time_remaining["minutes"] -= 1
	if time_remaining["minutes"] < 0:
		_decrement_hours()
		time_remaining["minutes"] = 59
	
func _decrement_hours():
	time_remaining["hours"] -= 1
	if time_remaining["hours"] < 0:
		time_remaining["hours"] = 59
		
		
func _check_timer_complete():
	if time_remaining["hours"] > 0: return false
	if time_remaining["minutes"] > 0: return false
	if time_remaining["seconds"] > 0: return false
	return true
	
func _check_warning_tick():
	if time_remaining["hours"] > 0: return 
	if time_remaining["minutes"] > 0: return 
	if time_remaining["seconds"] >= warning_ticks: return 
	emit_signal("warning_tick")
	SoundManager.play_tick_snd()
	
func save():
	print("saving simple timer")
	var dir_exists = DirAccess.dir_exists_absolute("user://" + path)
	if !dir_exists: DirAccess.make_dir_absolute("user://" + path)
	ResourceSaver.save(self, "user://" + path + "/" + id + ".tres")
	
func delete_file():
	DirAccess.remove_absolute("user://" + path + "/" + id + ".tres")
