extends Control

onready var fader = $Fader
onready var check_backsound = $Fader/Background/BoxBackground/ContainerSound/ContainerBacksound/CheckBacksound
onready var check_sfx = $Fader/Background/BoxBackground/ContainerSound/ContainerSFX/CheckSFX

var data

func _ready():
	fader._fade_in()
	data = Database.loadData()
	
	check_backsound.pressed = data["game_settings"]["sound"]["backsound"]
	check_sfx.pressed = data["game_settings"]["sound"]["sound_fx"]
	


func _on_CheckBacksound_pressed():
	save_sett_sound()


func _on_CheckSFX_pressed():
	save_sett_sound()


func save_sett_sound():
	if check_backsound.pressed == true:
		data["game_settings"]["sound"]["backsound"] = true
	else: data["game_settings"]["sound"]["backsound"] = false
	
	if check_sfx.pressed == true:
		data["game_settings"]["sound"]["sound_fx"] = true
	else: data["game_settings"]["sound"]["sound_fx"] = false
	
	Database.save_data(data)
	
	if not MenuBacksound.is_playing() and check_backsound.pressed:
		MenuBacksound.play()
		
	if MenuBacksound.is_playing() and not check_backsound.pressed:
		MenuBacksound.stop()


func _on_Exit_pressed():
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
