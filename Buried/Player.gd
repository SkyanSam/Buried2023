extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -3000
export (int) var gravity = 4000
export (int) var falling_gravity = 6000;
#later apply a timer so that if the character is slightly off the ledge, they can still jump

var velocity = Vector2.ZERO

func get_input():
	velocity.x = 0
	#if ui_right is pressed, velocity is increased to the right and sprite is flipped
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		$AnimatedSprite.flip_h = false
	#if ui_right is pressed, velocity is increased to the left and sprite is flipped
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
	if Input.is_action_just_released("ui_up"):
		if velocity.y < 0.0:
			velocity.y *= .2

