extends Node
#default auto attack
@export var player : CharacterBody3D
@export var weapon_hitbox : Area3D

var cooldown : float = 0.1
@onready var animations = get_parent().get_parent().find_child("AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Left_Click"):
		if	player.in_animation == true:
				if animations.current_animation == '1H_Melee_Attack_Chop':
					animations.clear_queue()
					animations.queue("1H_Melee_Attack_Slice_Horizontal")
		else:
			player.in_animation = true
			animations.speed_scale = 1.5
			animations.play('1H_Melee_Attack_Chop')
