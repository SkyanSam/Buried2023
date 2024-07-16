extends Area2D

@export var terminal_speed : int = 500
@export var terminal_speed_time : float = 1
enum StalactiteStage {
	STATIONARY,
	FALLING,
	PARTICLES,
}
var stage: StalactiteStage = StalactiteStage.STATIONARY
var time_passed = 0;
var speed = 0;
func _ready():
	$CPUParticles2D.visible = false
	$Sprite2D.visible = true
	set_component_rects()

func set_component_rects():
	var width = $Sprite2D.texture.get_width()
	var height = $Sprite2D.texture.get_height()
	$CollisionShape2D.shape.extents = Vector2(width, height) 
	$CPUParticles2D.emission_rect_extents.x = width / 3.0;
	$CPUParticles2D.emission_rect_extents.y = height

func _process(delta):
	if stage == StalactiteStage.FALLING:
		if time_passed < terminal_speed_time:
			speed = lerp(0, terminal_speed, time_passed / terminal_speed_time);
		else:
			speed = terminal_speed;
		position += Vector2.DOWN * speed * delta;
		time_passed += delta

# check if it hits the ground, if so start particles.
func _on_body_entered(body):
	if body.name == "GroundArea2D":
		stage = StalactiteStage.PARTICLES
		$Sprite2D.visible = false
		$CPUParticles2D.visible = true
		$CPUParticles2D.restart()

# returns true if this stalactite is eligible to start falling, else return false
func set_stage_to_falling():
	if stage == StalactiteStage.STATIONARY:
		stage = StalactiteStage.FALLING
		return true
	else:
		return false
