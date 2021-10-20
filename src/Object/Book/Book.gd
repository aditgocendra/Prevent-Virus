extends Area2D

var pick = false


func _input(event):
	if event.is_action_pressed("pick_up"):
		if pick == true:
			var tool_pick = Utility.tool_pickup
			Utility.tool_pickup = [tool_pick[0], 1, tool_pick[2]]
			queue_free()
			pick = false


func _on_Book_body_entered(body):
	if body.name == "Player":
		body.grab_btn()
		pick = true


func _on_Book_body_exited(body):
	if body.name == "Player":
		body.grab_btn()
		pick = false
