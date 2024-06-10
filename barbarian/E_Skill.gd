extends TextureRect
#go invisible
@export var player : CharacterBody3D
@export var trap : PackedScene

var previousbomb = null

var cooldown : float = 10
@onready var animations = get_parent().get_parent().find_child("AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready():
	cooldown = cooldown / 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("e") and $E_icon.value == 0:
		$E_icon.value = 100
		if previousbomb :
			previousbomb.queue_free()
		var new_trap = trap.instantiate()
		new_trap.global_transform =  $"../..".global_transform
		var scene_root = get_tree().get_root().get_children()[0]
		scene_root.add_child(new_trap)
		previousbomb = new_trap



func _on_timer_timeout():
	$E_icon.value -= 1 / cooldown
