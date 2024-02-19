extends Node

enum timer_state {
	PAUSED,
	RUNNING,
	STOPPED
}

const SAVE_TIMERS_DIR = "user://saved_timers/"
