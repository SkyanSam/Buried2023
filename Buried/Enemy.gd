extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
export (Vector2) var knockback = Vector2.ONE

var velocity = Vector2.ZERO


func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	#if is_on_floor():
		#velocity = knockback
	#if Input.is_action_just_pressed("ui_up"):
		#if is_on_floor():
			#velocity.y = jump_speed

func do_knockback():
	velocity = knockback
