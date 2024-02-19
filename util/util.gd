extends Node

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


func uuid():
	var now = str(int(Time.get_unix_time_from_system()))
	return now + "-" + str(rng.randi_range(0, 1000000))
