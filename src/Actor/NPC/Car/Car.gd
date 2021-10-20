extends Sprite

onready var path_follow = get_parent()
export var speed = 100

func _process(delta):
	path_follow.offset += speed * delta


func _on_AreaHit_body_entered(body):
	if body.name == "Player":
		Utility.emit_signal("object_crash")
