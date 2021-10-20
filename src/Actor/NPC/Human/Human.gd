extends Area2D

onready var path_follow = get_parent()
export var speed = 40
onready var animated_sprite = $AnimatedSprite
onready var girl_frame = load("res://src/Actor/NPC/Human/Girl.tres")
onready var man_frame = load("res://src/Actor/NPC/Human/Man.tres")
onready var woman_frame = load("res://src/Actor/NPC/Human/Woman.tres")

var is_spray = false

func _ready():
	randomize()
	var random_sprite = randi()%3+1
	if random_sprite == 1:
		animated_sprite.frames = girl_frame
	elif random_sprite == 2:
		animated_sprite.frames = man_frame
	else: animated_sprite.frames = woman_frame
	
	
func _process(delta):
	var old_pos = self.global_position
	
	if Utility.current_stage != 4 or is_spray:
		path_follow.offset += speed * delta
	
	var direction = self.global_position - old_pos
	
#	print(int(round(direction.x)) , " ", int(round(direction.y)))
	if int(round(direction.x)) != 0:
		animated_sprite.play("WalkSide")
			
		if int(round(direction.x)) == 1:
			animated_sprite.flip_h = false
		else: animated_sprite.flip_h = true
			
	elif int(round(direction.y)) != 0:
			
		if int(round(direction.y)) == 1:
			animated_sprite.play("WalkFront")
		else: animated_sprite.play("WalkBack")
	elif old_pos == self.global_position:
		animated_sprite.play("Idle")
		 
	
func run():
	is_spray = true
	
	
func _on_AreaHuman_body_entered(body):
	if body.name == "Player" and not is_spray:
		Utility.emit_signal("object_crash")


func _on_AreaTop_body_entered(body):
	if body.name == "Player":
		self.z_index = 2


func _on_AreaBottom_body_entered(body):
	if body.name == "Player":
		self.z_index = -1
