extends Line2D

export var chain_speed = 500
export var chain_parry_time = 1.0
var chain_origin : Vector2 = Vector2(0,0)
export var chain_target_path : NodePath
var chain_end_pos : Vector2
enum ChainMode { Ejecting, Returning, Parrying }
var chain_mode : int = ChainMode.Ejecting

var is_chain_end_pos_initialized = false
var time_since_parry = 0.0

func _enter_tree():
	# Setting the points for the chain
	points.resize(2)
	points[0] = chain_origin
	points[1] = chain_origin
	
func _physics_process(delta):
	if not is_chain_end_pos_initialized:
		is_chain_end_pos_initialized = true
		# Getting the position we want the chain to end at
		var chain_target_node = get_node(chain_target_path) as Node2D
		chain_end_pos = get_end_position(chain_target_node.global_position)

func _process(delta):
	if chain_mode == ChainMode.Parrying:
		# Compute parry points and update time since parry.
		set_points_parry(chain_end_pos, chain_origin, time_since_parry / chain_parry_time)
		time_since_parry += delta
	else:
		# Seeing if we need to eject the chain or retract the chain from the end position
		var chain_target : Vector2
		if chain_mode == ChainMode.Ejecting and is_chain_end_pos_initialized:
			chain_target = chain_end_pos
		else:
			chain_target = chain_origin
		points[0] = points[0].move_toward(chain_target, delta * chain_speed)
		$ChainEnd.position = points[0] # check if it needs to be global
		time_since_parry = 0.0 # Reset variable for future use.

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
	
	if $RayCast2D.is_colliding():
		return $RayCast2D.get_collision_point()
	else:
		return chain_target_position

func get_normal(vec):
	return Vector2(vec.y,-vec.x)

# During the parry the chain consists of a line and a half circle.
func set_points_parry(chain_end, chain_start, t):
	# Count must be at least 3.
	var count = 20 
	# Initialize array
	var new_pts = []
	new_pts.resize(count)
	# Compute non circle points.
	new_pts[count - 1] = chain_start
	new_pts[count - 2] = lerp(chain_end, chain_start, t)
	# Computing circle variables.
	var normal = get_normal(chain_end - chain_start).normalized()
	var circle_radius = (normal * (new_pts[count - 2] - chain_end).length()) # may need to be altered
	var circle_center = new_pts[count - 2] + (normal * circle_radius)
	var circle_pts_num = count - 3
	# Computing circle points.
	for i in range(0, circle_pts_num):
		var angle = lerp((1.5*PI) - (t*PI*2), 1.5*PI, float(i) / float(circle_pts_num))
		new_pts[i] = circle_center + (circle_radius * Vector2(cos(angle), sin(angle)))
	# Set points to new points
	points = PoolVector2Array(new_pts)
