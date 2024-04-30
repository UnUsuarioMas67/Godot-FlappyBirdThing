extends CanvasLayer

signal transition_halfway

@onready var color_rect = $ColorRect


func transition():
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color.WHITE, 0.2)
	tween.tween_interval(0.2)
	tween.tween_callback(_emit_transition_halfway)
	tween.tween_property(color_rect, "modulate", Color.TRANSPARENT, 0.3)


func _emit_transition_halfway():
	transition_halfway.emit()
