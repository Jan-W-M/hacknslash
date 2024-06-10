extends TextureRect

@export var player : CharacterBody3D
@export var weapon_hitbox : Area3D

var cooldown : float = 0.1
@onready var animations = get_parent().get_parent().find_child("AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	$E_CD.wait_time = cooldown /100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("e") and $E_icon.value == 0:
		$E_icon.value = 100
		player.in_animation = true
		animations.play('2H_Melee_Attack_Spin')


func _on_timer_timeout():
	$E_icon.value -= 1
