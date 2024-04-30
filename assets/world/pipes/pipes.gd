extends Node2D


func _process(delta):
	position.x -= Globals.current_game_speed * delta
