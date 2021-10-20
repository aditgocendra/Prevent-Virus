extends Control

onready var fader = $Fader
onready var next_scene = ""

func _ready():
	fader.connect("fade_finish", self, "on_fade_finish")
	fader._fade_in()
	
	var data = Database.loadData()
	var backsound = data["game_settings"]["sound"]["backsound"]
	
	if not MenuBacksound.is_playing() and backsound:
		MenuBacksound.play()


func on_fade_finish(anim):
	if anim == "fade_in":
		$AnimationPlayer.play("start")
		pass
	else: get_tree().change_scene(next_scene)


func _on_Play_pressed():
	next_scene = "res://src/UserInterface/Stage/Stage.tscn"
	fader._fade_out()


func _on_Intro_pressed():
	next_scene = "res://src/UserInterface/Education/Education.tscn"
	fader._fade_out()


func _on_About_pressed():
	next_scene = "res://src/UserInterface/About/About.tscn"
	fader._fade_out()


func _on_Settings_pressed():
	next_scene = "res://src/UserInterface/Settings/Settings.tscn"
	fader._fade_out()


func _on_Exit_pressed():
	get_tree().quit()
