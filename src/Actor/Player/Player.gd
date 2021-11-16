extends KinematicBody2D

var speed = 90
var acceleration = 9
var friction = 9
var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO

onready var camera = $Camera2D
onready var pause_overlay = $ControlInterface/PauseOverlay
onready var spray_button = $ControlInterface/RightContainer
onready var area_spray = $AreaSpray
onready var area_col_spray = $AreaSpray/CollisionPolygon2D
onready var joystick = $ControlInterface/Joystick/Joy

var sfx_data

# direction before to zero
var direction_idle_pos : Vector2

func _ready():
	var data = Database.loadData()
	sfx_data = data["game_settings"]["sound"]["sound_fx"]
	
	camera.limit_right = get_parent().limit_screen_right
	camera.limit_bottom = get_parent().limit_screen_bottom
	
	if Utility.current_stage == 4:
		spray_button.show()
	
	
func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		pause_overlay.show()

		
func _physics_process(delta):
	direction = Vector2.ZERO
	
	if $TimerSpray.is_stopped():
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
			
		if Input.is_action_pressed("move_right"):
			direction.x += 1
			
		if Input.is_action_pressed("move_top"):
			direction.y -= 1
		
		if Input.is_action_pressed("move_bottom"):
			direction.y += 1
		
		direction = joystick.get_4_direction()
		
		
	# Area spray rotation
	if $TimerSpray.is_stopped():
		if direction_idle_pos.x > 0:
			area_spray.rotation_degrees = -90
		elif direction_idle_pos.x < 0:
			area_spray.rotation_degrees = 90
		elif direction_idle_pos.y > 0 or direction_idle_pos.y == 0:
			area_spray.rotation_degrees = 0
		else: area_spray.rotation_degrees = 180
	
	
	var spray = false
	if Input.is_action_just_pressed("spray"):
		spray = true
		
		
	var animation =  control_animation(direction, spray)
	
	if $AnimatedSprite.animation != animation and $TimerSpray.is_stopped():
		if spray:
			$TimerSpray.start()
		$AnimatedSprite.play(animation)
		
		
	if $TimerSpray.is_stopped():
		area_col_spray.disabled = true
	else : area_col_spray.disabled = false
	
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		velocity += direction * acceleration * delta
		velocity = velocity.clamped(speed * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_collide(velocity)
	
	if direction != Vector2.ZERO and not $FootTile.is_playing() and sfx_data:
		$FootTile.play()
		
	
func control_animation(direct, spray):
	var anim = "Idle"
	
	if direct.x > 0 or direct.x < 0:
		if spray:
			anim = "SpraySide"
		else:
			if Utility.current_stage > 2 or Utility.mask_pickup > 0:
				anim = "SideMask"
			else: anim = "Side"
		
		if direct.x > 0 :
			$AnimatedSprite.flip_h = false
		else : $AnimatedSprite.flip_h = true
	
	if direct.y > 0:
		if spray:
			anim = "SprayFront"
		else:
			if Utility.current_stage > 2 or Utility.mask_pickup > 0:
				anim = "FrontMask"
			else: anim = "Front"
	
	if direct.y < 0:
		if spray:
			anim = "SprayBack"
		else:
			anim = "Back"
	
	# get direct before realese direction to zero
	if direct.x != 0 or direct.y != 0:
		direction_idle_pos = direct
		
	
	if direct.x == 0 and direct.y == 0:
		if spray:
			if direction_idle_pos.x > 0 or direction_idle_pos.x < 0 :
				anim = "SpraySide"
			elif direction_idle_pos.y < 0:
				anim = "SprayBack"
			elif direction_idle_pos.y > 0:
				anim = "SprayFront"
		else:
			if Utility.current_stage > 2 or Utility.mask_pickup > 0:
				
				if direction_idle_pos.x > 0 or direction_idle_pos.x < 0 :
					anim = "SideIdleMask"
				elif direction_idle_pos.y < 0:
					anim = "IdleBack"
				elif direction_idle_pos.y > 0:
					anim = "IdleMask"
			else: 
				if direction_idle_pos.x > 0 or direction_idle_pos.x < 0:
					anim = "SideIdle"
				elif direction_idle_pos.y < 0:
					anim = "IdleBack"
				elif direction_idle_pos.y > 0: 
					anim = "Idle"
				
	return anim

func grab_btn():
	if $ControlInterface/Grab.visible == false:
		$ControlInterface/Grab.show()
	else:$ControlInterface/Grab.hide()


func _on_Next_pressed():
	get_tree().paused = false
	pause_overlay.hide()
	

func _on_Retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	
func _on_Stage_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://src/UserInterface/Stage/Stage.tscn")


func _on_AreaSpray_area_entered(area):
	if area.name == "AreaHuman":
		area.run()
		print(area.name)


func _on_Home_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
