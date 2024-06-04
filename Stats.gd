extends Node

class_name stats

@export var max_hp = 10

var current_hp = max_hp

signal dying

func _ready():
	pass # Replace with function body.



func _process(_delta):
	pass

func take_hit(damage):
	print(damage)
	current_hp -= damage
	
	if current_hp == 0:
		die()
		
func die():
	emit_signal("dying")
