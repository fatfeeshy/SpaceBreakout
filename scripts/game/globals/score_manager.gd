extends Node

static var wave_started : bool
static var score : float
var wave_score : float
var wave_multiplier : float

func _ready() -> void:
	score = 0
	wave_score = 0

#func _process(_delta: float) -> void:
	#pass

func DetermineScore():
	print("Raw Score: " + str(wave_score))
	var wave_mult_divisor := 10
	var wave_timer_score = WaveTimer.time_left
	print("Wave Multiplier (Raw): " + str(wave_timer_score))
	wave_multiplier = (wave_timer_score / wave_mult_divisor) + 1
	print("Wave Multiplier (Net): " + str(wave_multiplier))
	score += int(wave_score * wave_multiplier)
	print("Final Score: " + str(score))
	wave_score = 0
