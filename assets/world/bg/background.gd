extends Sprite2D

@export var speed_mult := 0.5


func _process(delta):
	region_rect.position.x += Globals.current_game_speed * speed_mult * delta
