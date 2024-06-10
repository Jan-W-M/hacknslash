extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_attack():
	pass



func _on_knife_hitbox_entered(body):
	if body.has_node("Stats"):
		print('hey')
		if $"..".animations.current_animation == "1H_Melee_Attack_Stab":
			var stats_node = body.find_child("Stats")
			stats_node.take_hit(10)

