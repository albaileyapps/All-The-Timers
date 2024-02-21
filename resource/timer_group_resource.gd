extends Resource
class_name TimerGroup

@export var title: String
@export var path: String
@export var id: String
@export var index: int
@export var sequential: bool

var children: Array = []
var children_loaded = false

func _init(p_title: String = "", p_id: String = "", p_path: String = "", p_index: int = 0, p_sequential = false):
	title = p_title
	id = p_id
	path = p_path
	index = p_index
	sequential = p_sequential
	print("init timer group")
	
#a TimerGroup loads its children timers when it is opened in a timer group view
func load_children():
	if children_loaded: 
		emit_changed()
		return
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
					res.complete.connect(_on_child_timer_complete)
					children.append(res)
				else:
					print("res is not a known timer, but does exist...")
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		DirAccess.make_dir_absolute("user://" + path)
	children.sort_custom(func(a, b): return a.id < b.id)
	emit_changed()
	children_loaded = true
	
#a timer group loads its children when a list item is pressed and the group view is opened
# when that view is closed, the TimerGroup resource still exists, so unload children manually
func unload_children():
	children.clear()
	children_loaded = false

func add_timer_group(p_group: TimerGroup):
	var id = Util.uuid()
	p_group.id = id
	p_group.path = path + "/" + id
	p_group.index = 0 #not in use yet
	p_group.save()
	children.append(p_group)
	emit_changed()
	
func add_timer_simple(p_timer: TimerSimple):
	var id = Util.uuid()
	p_timer.id = id
	p_timer.path = path
	p_timer.index = 0 #index not in use yet
	p_timer.complete.connect(_on_child_timer_complete)
	p_timer.save()
	children.append(p_timer)
	emit_changed()
	
func delete_timer_simple(p_timer: TimerSimple):
	children.erase(p_timer)
	emit_changed()
	
func delete_timer_group():
	pass
	
func _on_child_timer_complete(p_child: TimerSimple):
	print("child timer complete")
	
func save():
	var dir_exists = DirAccess.dir_exists_absolute("user://" + path)
	if !dir_exists: DirAccess.make_dir_absolute("user://" + path)
	ResourceSaver.save(self, "user://" + path + ".tres")
	
func process(delta):
	for timer in children:
		if timer is TimerSimple:
			
			timer.process(delta)
