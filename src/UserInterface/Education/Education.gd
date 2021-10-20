extends Control

var counter_education = 1
onready var content_image1 = load("res://assets/Education/MaskEdu.png")
onready var content_image2 = load("res://assets/Education/Distance.png")
onready var content_image3 = load("res://assets/Education/Crowd.png")
onready var content_image4 = load("res://assets/Education/WashHand.png")
onready var content_image5 = load("res://assets/Education/StayAtHome.png")

onready var illustration_texture = $Background/EducationBG/ContentContainer/Illustration
onready var label_edu = $Background/EducationBG/ContentContainer/LabelEducation
onready var back_btn = $Background/EducationBG/Back
onready var next_btn = $Background/EducationBG/Next

func change_content():
	if counter_education == 1:
		illustration_texture.texture = content_image1
		label_edu.text = "Pakailah masker untuk langkah awal pencegahan tertular dari virus"
		
	
	if counter_education == 2:
		illustration_texture.texture = content_image2
		label_edu.text = "Jagalah jarak dengan orang lain minimal 1 meter,  mencegah menularnya virus"
		
	if counter_education == 3:
		illustration_texture.texture = content_image3
		label_edu.text = "Jauhi keramaian untuk mencegahnya penularan virus"
		
	if counter_education == 4:
		illustration_texture.texture = content_image4
		label_edu.text = "Cucilah tangan dengan sabun untuk menghilangkan kuman dan virus-virus ditangan"
		
	if counter_education == 5:
		illustration_texture.texture = content_image5
		label_edu.text = "Tetap dirumah jika tidak ada keperluan yang sangat mendesak untuk menekan pertumbuhan covid 19"
		
	if counter_education== 5:
		next_btn.hide()
	else: next_btn.show()
	
	if counter_education == 1:
		back_btn.hide()
	else: back_btn.show()
	

func _on_Next_pressed():
	if not counter_education >= 5 and not $AnimationPlayer.is_playing():
		counter_education += 1
		$AnimationPlayer.play("change_content")


func _on_Back_pressed():
	if not counter_education <= 1 and not $AnimationPlayer.is_playing():
		counter_education -= 1
		$AnimationPlayer.play("change_content")
	

func _on_Exit_pressed():
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
