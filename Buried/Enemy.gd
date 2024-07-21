extends CharacterBody2D

@export var speed: int = 1200
@export var jump_speed: int = -1800
@export var gravity: int = 4000
@export var knockback: Vector2 = Vector2.ONE

var vel : Vector2 = Vector2.ZERO


func _physics_process(delta):
	vel.y += gravity * delta
	set_velocity(vel)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity = vel
	if is_on_floor():
		vel = knockback
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			vel.y = jump_speed

func do_knockback():
	vel = knockback
