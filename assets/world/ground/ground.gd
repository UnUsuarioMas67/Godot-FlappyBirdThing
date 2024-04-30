extends StaticBody2D

@onready var sprite = $Sprite2D


func _process(delta):
	sprite.region_rect.position.x += Globals.current_game_speed * delta
