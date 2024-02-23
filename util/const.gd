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

const color_sets = {
	1: {"top": "D02323", "bottom": "FF7E39"},
	2: {"top": "EE6713", "bottom": "FFB039"},
	3: {"top": "49B318", "bottom": "41EB83"},
	4: {"top": "245CBD", "bottom": "42B7F5"},
	5: {"top": "5825A3", "bottom": "BE58E9"},
	6: {"top": "A633C0", "bottom": "F350F0"},
	7: {"top": "D023A2", "bottom": "F75F5F"},
	8: {"top": "23D093", "bottom": "41C8DA"},
}
