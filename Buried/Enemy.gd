extends CharacterBody2D

@export (int) var speed = 1200
@export (int) var jump_speed = -1800
@export (int) var gravity = 4000
@export (Vector2) var knockback = Vector2.ONE

var velocity = Vector2.ZERO


func _physics_process(delta):
	velocity.y += gravity * delta
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity = velocity
	if is_on_floor():
		velocity = knockback
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed

func do_knockback():
	velocity = knockback
