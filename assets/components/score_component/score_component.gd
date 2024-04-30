extends Node
class_name ScoreComponent

signal score_updated(new_score: int)

var score := 0
var old_high_score := 0


func _ready():
	GameEvents.pipe_passed.connect(_on_pipe_passed)
	GameEvents.player_died.connect(_on_player_died)
	
	old_high_score = UserData.save_data["high_score"]


func _on_pipe_passed():
	score += 1
	score_updated.emit(score)


func _on_player_died():
	UserData.submit_score(score)
