extends CharacterBody3D


@onready var player = $"../player" as CharacterBody3D
#@onready var player = $"../player" as CharacterBody3D
@export var rotation_speed : float = 8
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

var movement_speed: float = 2.0
var movement_target_position: Vector3 = Vector3(-3.0,0.0,2.0)
var path = [] 
var attacking

var in_animation = false

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5

func actor_setup():

	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	# Now that the navigation map is no longer empty, set the movement target.
	var player_location = player.global_transform.origin
	player_location.y = -10

	set_movement_target(player.global_transform.origin)



func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)
	
func _physics_process(delta):
	move_and_slide() 
	var target_rotation = atan2(velocity.x, velocity.z)
	$Node3D.rotation.y = lerp_angle($Node3D.rotation.y, target_rotation, rotation_speed * delta)


func _on_stats_dying():
	velocity = Vector3.ZERO
	in_animation = true
	$Node3D/AnimationPlayer.play("Death_A")
	await get_tree().create_timer(2.0).timeout
	queue_free()


func _on_timer_timeout():
	actor_setup()
	if navigation_agent.is_navigation_finished():
		return
	if not in_animation:
		$Node3D/AnimationPlayer.play("Walking_D_Skeletons")
		var current_agent_position: Vector3 = global_position
		var next_path_position: Vector3 = navigation_agent.get_next_path_position()
		velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	
