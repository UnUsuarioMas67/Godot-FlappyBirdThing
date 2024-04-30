extends Node

const END_MENU_SCENE: PackedScene = preload("res://assets/ui/end_menu/end_menu.tscn")

@export var score_component: ScoreComponent


func _ready():
	GameEvents.reset.emit()
	GameEvents.player_died.connect(_on_player_died)


func _on_player_died():
	var end_menu = END_MENU_SCENE.instantiate()
	end_menu.score_component = score_component
	add_child(end_menu)
