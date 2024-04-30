extends Area2D

var velocity := Vector2.ZERO
var is_active := false
var is_dead := false
var anim_tween: Tween

var ground_node: Node2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tap_label: Label = $TapLabel
@onready var jump_sound = $JumpSound
@onready var hit_sound = $HitSound


func _ready():
	GameEvents.game_started.connect(_on_game_started)
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)


func _physics_process(delta):
	var prev_velocity := velocity
	
	# gravity
	if is_active:
		velocity.y += Globals.PLAYER_GRAVITY * delta
	
	# jumping
	if Input.is_action_just_pressed("jump") and !is_dead:
		velocity.y = -Globals.PLAYER_JUMP_HEIGHT
		_tween_jump()
		jump_sound.play()
		if !is_active:
			is_active = true
			GameEvents.game_started.emit()
	
	# fall animation
	if prev_velocity.y < 0 && velocity.y >= 0:
		_tween_fall()
	
	position += velocity * delta
	
	if !ground_node:
		_get_ground()
	position.y = clampf(global_position.y, 0, ground_node.global_position.y + 4)


func _tween_jump():
	if anim_tween != null and anim_tween.is_valid():
		anim_tween.kill()
	
	anim_tween = create_tween()
	anim_tween.tween_property(anim_sprite, "rotation_degrees", -25.0, 0.15)


func _tween_fall():
	if anim_tween != null and anim_tween.is_valid():
		anim_tween.kill()
	
	anim_tween = create_tween()
	anim_tween.tween_property(anim_sprite, "rotation_degrees", 90.0, 0.75)


func _get_ground():
	ground_node = get_tree().get_first_node_in_group("ground") as Node2D


func _on_game_started():
	var tween := create_tween()
	tween.tween_property(tap_label, "modulate", Color.TRANSPARENT, 0.1)
	tween.tween_callback(tap_label.hide)


func _on_body_entered(body: Node2D):
	if is_dead or !is_active:
		return
	
	is_dead = true
	anim_sprite.stop()
	hit_sound.play()
	GameEvents.player_died.emit()


func _on_area_entered(area: Area2D):
	GameEvents.pipe_passed.emit()
