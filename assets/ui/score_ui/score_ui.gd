extends CanvasLayer

@export var score_component: ScoreComponent

@onready var score_value: Label = %ScoreValue
@onready var control: Control = $Control
@onready var score_sound = $ScoreSound


func _ready():
	if score_component:
		score_component.score_updated.connect(_on_score_updated)
	
	GameEvents.game_started.connect(_on_game_started)
	GameEvents.player_died.connect(_on_player_died)
	
	control.hide()


func _on_score_updated(new_score: int):
	score_value.text = str(new_score)
	score_sound.play()
	
	var tween := create_tween()
	tween.tween_property(score_value, "scale", Vector2(1.4, 1.4), 0.05)
	tween.tween_property(score_value, "scale", Vector2.ONE, 0.25)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)


func _on_game_started():
	control.show()


func _on_player_died():
	var tween := create_tween()
	var target_position := Vector2(score_value.position.x, -50)
	
	tween.tween_property(score_value, "position", target_position, 0.5)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
