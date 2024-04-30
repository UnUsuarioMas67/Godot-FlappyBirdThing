extends Node

@export var scroll_effect_material: ShaderMaterial = preload("res://assets/components/scroll_effect/scroll_effect_material.tres")
@export var sprite: Sprite2D
@export var speed_scale := 1.0


func _ready():
	sprite.material = scroll_effect_material.duplicate()
	sprite.material.set("shader_parameter/motion", Vector2(Globals.GAME_SPEED * speed_scale, 0))
	sprite.material.set("shader_parameter/offset", sprite.texture.get_size() / 2)
