extends TextureRect
#no real idea yet

@export var player : CharacterBody3D

var cooldown : float = 5
@onready var animations = get_parent().get_parent().find_child("AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	cooldown = cooldown / 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("q") and $Q_icon.value == 0:
		$Q_icon.value = 100
		player.in_animation = true
		animations.speed_scale = 2
		animations.play('1H_Melee_Attack_Chop')


func _on_timer_timeout():
	$Q_icon.value -= 1 / cooldown
