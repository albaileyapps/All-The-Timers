extends Node

enum timer_state {
	PAUSED,
	RUNNING,
	STOPPED
}

const SAVE_TIMERS_DIR = "user://saved_timers/"

const VIEW_EXIT_DURATION = 0.2
const VIEW_ENTER_DURATION = 0.2
const VIEW_ENTER_DELAY = 0.3
