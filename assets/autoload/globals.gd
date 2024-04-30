extends Node

const PLAYER_JUMP_HEIGHT := 225.0
const PLAYER_GRAVITY := 700.0

const DISTANCE_BETWEEN_PIPES := 96
const PIPE_Y_MIN := 64
const PIPE_Y_MAX := 176

const GAME_SPEED := 75.0

var current_game_speed := GAME_SPEED


func _ready():
	GameEvents.player_died.connect(
		func():
			current_game_speed = 0
	)
	GameEvents.reset.connect(
		func():
			current_game_speed = GAME_SPEED
	)
