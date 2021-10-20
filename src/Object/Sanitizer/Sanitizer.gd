extends Sprite

var pick = false

func _input(event):
	if event.is_action_pressed("pick_up"):
		if pick == true:
			Utility.sanitizer_pick += 1 
			queue_free()
			pick = false

func _on_AreaPick_body_entered(body):
	if body.name == "Player":
		body.grab_btn()
		pick = true


func _on_AreaPick_body_exited(body):
	if body.name == "Player":
		body.grab_btn()
		pick = false 

