extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
export (int) var falling_gravity = 6000;

var velocity = Vector2.ZERO

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	get_input()
	
	if (velocity.y > 0):
		velocity.y += gravity * delta
	else:
		velocity.y += falling_gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed
			

