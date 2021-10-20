extends Control

onready var star_progress = $ContainerStars/StarProgress
onready var star_progress2 = $ContainerStars/StarProgress2
onready var star_progress3 = $ContainerStars/StarProgress3
onready var text_end = $ContainerStars/Text
var max_star = 3

func play_win_frame():
	text_end.texture = load("res://assets/Decoration/WinText.png")
	$AnimationPlayer.play("Win")

func play_lose_frame():
	text_end.texture = load("res://assets/Decoration/LoseText.png")
	$AnimationPlayer.play("Lose")

func _on_TimerProgress_timeout():
	if star_progress.value <= 80:
		star_progress.value += 1
		
	if max_star > 1 and star_progress.value == 80:
		star_progress2.value += 1
	
	if max_star > 2 and star_progress2.value == 80:
		star_progress3.value += 1
	
	
func _on_RetryBtn_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	Utility.mask_pickup = 0


func _on_StageBtn_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://src/UserInterface/Stage/Stage.tscn")
	Utility.mask_pickup = 0

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Win":
		$TimerProgress.start()


func _on_StarProgress_value_changed(value):
	if value == 80 and max_star == 1:
		$TimerProgress.stop()


func _on_StarProgress2_value_changed(value):
	if value == 80 and max_star == 2:
		$TimerProgress.stop()


func _on_StarProgress3_value_changed(value):
	if value == 80 and max_star == 3:
		$TimerProgress.stop()
