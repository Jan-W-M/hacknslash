extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.has_node("Stats"):
		var stats_node = body.find_child("Stats")
		stats_node.take_hit(10)
		self.queue_free()

