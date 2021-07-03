extends KinematicBody2D

var speed = 100
var acceleration = 10
var friction = 10
var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO


func _physics_process(delta):
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		
	if Input.is_action_pressed("move_top"):
		direction.y -= 1
	
	if Input.is_action_pressed("move_bottom"):
		direction.y += 1
		
	control_animation(direction)
	
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		velocity += direction * acceleration * delta
		velocity = velocity.clamped(speed * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_collide(velocity)
	


func control_animation(direct):
	if direct.x > 0 or direct.x < 0:
		$AnimatedSprite.play("WalkSide")
		if direct.x > 0 :
			$AnimatedSprite.flip_h = false
		else : $AnimatedSprite.flip_h = true
	
	if direct.y > 0:
		$AnimatedSprite.play("WalkFront")
	
	if direct.y < 0:
		$AnimatedSprite.play("WalkBack")
	
	if direct.x == 0 and direct.y == 0:
		$AnimatedSprite.stop()

