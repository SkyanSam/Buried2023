extends Line2D

var chain_speed = 500;
var chain_origin : Vector2 = Vector2(0,0)
var chain_target : Vector2 = Vector2(1200,700)

func _ready():
	points.resize(2)
	points[0] = chain_origin;
	points[0] = chain_origin;

func _process(delta):
	points[0] = points[0].move_toward(chain_target, delta * chain_speed)
	$ChainEnd.position = points[0] # check if it needs to be global
	$RayCast2D.position = points[1]
	$RayCast2D.cast_to = points[0]
