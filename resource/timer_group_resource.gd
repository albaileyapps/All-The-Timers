extends Resource
class_name TimerGroup

@export var title: String
@export var path: String
@export var id: String
@export var index: int

var children: Array = []

func _init(p_title: String = "", p_id: String = "", p_path: String = "", p_index: int = 0):
	title = p_title
	id = p_id
	path = p_path
	index = p_index
	print("init timer group")
	
#a TimerGroup loads its children timers when it is opened in a timer group view
func load_children():
	var dir = DirAccess.open("user://" + path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension() == "tres":
				var res = ResourceLoader.load("user://" + path + "/" + file_name)
				if res is TimerGroup: 
					print("got a timer group")
					children.append(res)
				if res is TimerSimple:
					print("got a simple timer")
					children.append(res)
				else:
					print("res is not a known timer, but does exist...")
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		DirAccess.make_dir_absolute("user://" + path)
	children.sort_custom(func(a, b): return a.index < b.index)
	emit_changed()

func add_timer_group(p_title: String):
	var id = Util.uuid()
	var timer_group = TimerGroup.new(p_title, id, path + "/" + id, children.size())
	timer_group.save()
	children.append(timer_group)
	emit_changed()
	
func add_timer_simple(p_title: String, p_period: Dictionary):
	var id = Util.uuid()
	var timer_simple = TimerSimple.new(p_title, id, path, children.size(), p_period)
	timer_simple.save()
	children.append(timer_simple)
	emit_changed()
	
func remove_timer():
	pass
	
func save():
	var dir_exists = DirAccess.dir_exists_absolute("user://" + path)
	if !dir_exists: DirAccess.make_dir_absolute("user://" + path)
	ResourceSaver.save(self, "user://" + path + ".tres")
	
func process(delta):
	for timer in children:
		if timer is TimerSimple:
			
			timer.process(delta)
