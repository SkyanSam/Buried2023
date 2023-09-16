extends Line2D

var chain_speed = 500;
var chain_origin : Vector2 = Vector2(0,0)
export var chain_target_path : NodePath

func _ready():
	points.resize(2)
	points[0] = chain_origin;
	points[0] = chain_origin;

func _process(delta):
	var chain_target = (get_node(chain_target_path) as Node2D).global_position
	points[0] = points[0].move_toward(chain_target, delta * chain_speed)
	$ChainEnd.position = points[0] # check if it needs to be global
	$RayCast2D.position = points[1]
	$RayCast2D.cast_to = points[0]
