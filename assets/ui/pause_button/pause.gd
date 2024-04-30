extends CanvasLayer

@onready var pause_button = %PauseButton
@onready var pause_label = %PauseLabel


func _ready():
	pause_button.hide()
	pause_button.pressed.connect(_on_pause_button_pressed)
	
	GameEvents.game_started.connect(func(): pause_button.show())
	GameEvents.player_died.connect(func(): pause_button.hide())


func _input(event):
	if !pause_button.visible:
		return
	
	if event.is_action_pressed("pause"):
		_toggle_pause(
				true if !get_tree().paused
				else false
		)


func _toggle_pause(paused: bool):
	get_tree().paused = paused
	pause_label.visible = paused


func _on_pause_button_pressed():
	_toggle_pause(
			true if !get_tree().paused
			else false
	)
