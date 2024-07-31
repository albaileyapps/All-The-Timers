extends ViewBase

var timer: TimerSimple
var next_timer: TimerSimple = null
var previous_timer: TimerSimple = null

var title: String

signal timer_complete(p_view)
signal next_pressed(p_next_timer)
signal previous_pressed(p_previous_timer)

@onready var navbar = $VBoxContainer/NavBar

# Called when the node enters the scene tree for the first time.
func _ready():
	navbar.exit_pressed.connect(_on_exit_pressed)
	%TimeLabel.set_timer(timer)
	timer.time_elapsed_changed.connect(_on_timer_time_elapsed_changed)
	timer.changed.connect(_on_timer_changed)
	timer.complete.connect(_on_timer_simple_complete)
	BkgEventBus.emit_signal("set_bkg_color", timer.color_set)
	_build_ui()

	
func _on_timer_time_elapsed_changed():
	_build_ui()
	
func _on_timer_changed():
	_build_ui()
	
func _on_timer_simple_complete(p_timer: TimerSimple):
	emit_signal("timer_complete", self)
	
func _build_ui():
	%TitleLabel.visible =  !(timer.title.length() == 0)
	
	%TitleLabel.text = timer.title
	#var s = "%02d:%02d:%02d" % [t.hours, t.minutes, t.seconds]
	#var s = "%02d:%02d" % [t.minutes, t.seconds]
	%StopButton.disabled = (timer.state == Const.timer_state.STOPPED)
	%StartButton.disabled = (timer.state == Const.timer_state.RUNNING)
	%PauseButton.disabled = !(timer.state == Const.timer_state.RUNNING)
	
	%NextButton.disabled = !(timer.state == Const.timer_state.STOPPED) or !next_timer
	%PreviousButton.disabled = !(timer.state == Const.timer_state.STOPPED) or !previous_timer

func _on_exit_pressed():
	remove_from_parent_view(0.3)


func _on_start_button_pressed():
	timer.start()


func _on_stop_button_pressed():
	timer.stop()


func _on_pause_button_pressed():
	timer.pause()


func _on_previous_button_pressed():
	if previous_timer:
		emit_signal("previous_pressed", previous_timer)
		remove_from_parent_view(0.3)


func _on_next_button_pressed():
	if next_timer:
		emit_signal("next_pressed", next_timer)
		remove_from_parent_view(0.3)
