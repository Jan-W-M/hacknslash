extends CharacterBody3D

signal set_movement_direction()

@onready var animations = get_parent().find_child("AnimationPlayer")

var movement_direction : Vector3
var moving = 1

var in_animation = false

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
			animations.play("2H_Melee_Idle")
		moving = 0
	if Input.is_action_just_pressed("ui_cancel") and Input.mouse_mode == 2:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_pressed("ui_cancel") and Input.mouse_mode == 0:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func is_movement_ongoing():
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "2H_Melee_Attack_Spin":
		in_animation = false


func _on_area_3d_body_entered(body):
	if body.has_node("Stats"):
		if animations.current_animation == "2H_Melee_Attack_Spin":
			var stats_node = body.find_child("Stats")
			stats_node.take_hit(10)

