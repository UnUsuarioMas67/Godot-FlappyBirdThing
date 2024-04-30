extends Node

const PIPE_SCENE: PackedScene = preload("res://assets/world/pipes/pipes.tscn")

@onready var pipe_container: Node2D = $PipeContainer
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var end_point: Marker2D = $EndPoint

var newest_pipe: Node2D


func _ready():
	GameEvents.game_started.connect(_on_game_started)


func _process(delta):
	if !newest_pipe:
		return
	if spawn_point.position.x - newest_pipe.position.x >= Globals.DISTANCE_BETWEEN_PIPES:
		spawn_pipe()


func spawn_pipe():
	var reusable_pipes: Array = pipe_container.get_children().filter(
		func(pipe):
			return pipe.position.x <= end_point.position.x
	)
	
	var pipe_instance: Node2D
	
	if reusable_pipes.size() > 0:
		pipe_instance = reusable_pipes[0]
	else:
		pipe_instance = PIPE_SCENE.instantiate()
		pipe_container.add_child(pipe_instance)
	
	pipe_instance.position.x = spawn_point.position.x
	if newest_pipe:
		pipe_instance.position.y = randf_range(Globals.PIPE_Y_MIN, Globals.PIPE_Y_MAX)
	else:
		pipe_instance.position.y = spawn_point.position.y
	
	newest_pipe = pipe_instance


func _on_game_started():
	spawn_pipe()
