extends ColorRect

signal fade_finish



func _fade_out():
	$AnimationPlayer.play("fade_out")
	
func _fade_in():
	$AnimationPlayer.play("fade_in")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fade_finish", anim_name)
