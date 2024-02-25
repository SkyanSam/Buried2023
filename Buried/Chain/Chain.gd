extends Line2D

export var chain_speed = 500;
var chain_origin : Vector2 = Vector2(0,0)
export var chain_target_path : NodePath
var chain_end_pos : Vector2
enum ChainMode { Ejecting, Returning }
var chain_mode : int = ChainMode.Ejecting
func _enter_tree():
	# Setting the points for the chain
	points.resize(2)
	points[0] = chain_origin
	points[1] = chain_origin
	# Getting the position we want the chain to end at
	var chain_target_node = get_node(chain_target_path) as Node2D
	chain_end_pos = get_end_position(chain_target_node.global_position)

func _process(delta):
	# Seeing if we need to eject the chain or retract the chain from the end position
	var chain_target : Vector2
	if (chain_mode == ChainMode.Ejecting):
		chain_target = chain_end_pos
	else:
		chain_target = chain_origin
	points[0] = points[0].move_toward(chain_target, delta * chain_speed)
	$ChainEnd.position = points[0] # check if it needs to be global

# Determines if the chain reached the ground.
func has_reached_ground():
	return points[0] == chain_end_pos

func get_end_position(chain_target_position : Vector2):
	# Getting Direction from Ray to Player
	var dir : Vector2 = chain_target_position - chain_origin
	dir = dir.normalized()
	dir *= 100000
	
	# Initializing Ray
	$RayCast2D.position = chain_origin
	$RayCast2D.cast_to = dir
	
	# Forcing the ray to update
	$RayCast2D.force_update_transform()
	$RayCast2D.force_raycast_update()
	
	# Why isnt it colliding?
	# Search some tutorials or something
	if $RayCast2D.is_colliding():
		return $RayCast2D.get_collision_point()
	return chain_target_position
