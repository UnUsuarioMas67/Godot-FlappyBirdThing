extends CanvasLayer

var score_component: ScoreComponent

@onready var margin_container: MarginContainer = $MarginContainer
@onready var score_value: Label = %ScoreValue
@onready var best_value: Label = %BestValue
@onready var new_label = %NewLabel
@onready var retry_button: TextureButton = %RetryButton


func _ready():
	var viewport_height := margin_container.get_viewport_rect().size.y
	
	var tween := create_tween()
	tween.tween_property(margin_container, "position", Vector2.ZERO, 0.4)\
			.from(Vector2(0, -viewport_height)).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	score_value.text = str(score_component.score)
	
	var current_high_score: int = UserData.save_data["high_score"]
	best_value.text = str(current_high_score)
	
	if current_high_score != score_component.old_high_score:
		new_label.modulate = Color.WHITE
	
	retry_button.pressed.connect(_on_retry_button_pressed)


func _on_retry_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().reload_current_scene()
