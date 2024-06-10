extends CharacterBody3D

signal set_movement_direction()

@export var animations : AnimationPlayer

var movement_direction : Vector3
var moving = 1

var in_animation = false

var attack = ["1H_Melee_Attack_Chop","1H_Melee_Attack_Slice_Horizontal"]

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(_delta):
	#movement
	if is_movement_ongoing():
		set_movement_direction.emit(movement_direction)
	if Input.is_action_pressed("movement") and not in_animation:
		animations.play("Running_A")
		movement_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		movement_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
		moving = 1
	else:
		if in_animation == false:
			animations.play("Idle")
		moving = 0
	if Input.is_action_just_pressed("ui_cancel") and Input.mouse_mode == 2:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_pressed("ui_cancel") and Input.mouse_mode == 0:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func is_movement_ongoing():
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0
	

func _on_animation_player_animation_finished(anim_name):
	if attack.has(anim_name) and animations.get_queue().size() == 0:
		in_animation = false
		animations.speed_scale = 1
