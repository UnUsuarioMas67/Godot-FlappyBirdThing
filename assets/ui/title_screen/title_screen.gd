extends CanvasLayer


func _ready():
	GameEvents.game_started.connect(_on_game_started)


func _on_game_started():
	var tween := create_tween()
	tween.tween_property($Control, "modulate", Color.TRANSPARENT, 0.15)
	tween.tween_callback(queue_free)
