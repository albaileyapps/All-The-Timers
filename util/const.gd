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
	1: {"top": "3E1A74", "bottom": "9F41D9"},
	2: {"top": "842C98", "bottom": "D94FD6"},
	3: {"top": "BE2795", "bottom": "E34F4F"},
	4: {"top": "1D4B9C", "bottom": "31C2DF"},
	5: {"top": "BC2020", "bottom": "F0702B"},
	6: {"top": "E06010", "bottom": "EB9B21"},
	7: {"top": "3E9516", "bottom": "33D788"},
	8: {"top": "1CB27D", "bottom": "29B8CB"},
	9: {"top": "1A1A1A", "bottom": "737373"},
}
