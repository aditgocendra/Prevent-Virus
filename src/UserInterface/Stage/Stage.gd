extends Control

onready var container_stage = $Fader/Background/BoxBackground/CotainerStage
onready var fader = $Fader

var next_stage
var open_stage = 1
var data

func _ready():
	fader.connect("fade_finish", self, "on_fade_finish")
	fader._fade_in()
	
	data = Database.loadData()
	open_stage = data["stage_open"]
	_stage_open()
	
	if not MenuBacksound.is_playing() and data["game_settings"]["sound"]["backsound"]:
		MenuBacksound.play() 

func _stage_open():
	for i in range(open_stage):
		var child = container_stage.get_child(i)
		child.get_node("LockStage").hide()
		

func _on_StageBG1_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			var stage_1 = $Fader/Background/BoxBackground/CotainerStage/StageBG1
			if stage_1.get_node("LockStage").visible == false:
				Utility.current_stage = 1
				fader._fade_out()



func _on_StageBG2_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			var stage_2 = $Fader/Background/BoxBackground/CotainerStage/StageBG2
			if stage_2.get_node("LockStage").visible == false:
				Utility.current_stage = 2
				fader._fade_out()



func _on_StageBG3_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			var stage_3 = $Fader/Background/BoxBackground/CotainerStage/StageBG3
			if stage_3.get_node("LockStage").visible == false:
				Utility.current_stage = 3
				fader._fade_out()


func _on_StageBG4_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			var stage_4 = $Fader/Background/BoxBackground/CotainerStage/StageBG4
			if stage_4.get_node("LockStage").visible == false:
				Utility.current_stage = 4
				fader._fade_out()


func _on_StageBG5_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			var stage_5 = $Fader/Background/BoxBackground/CotainerStage/StageBG5
			if stage_5.get_node("LockStage").visible == false:
				Utility.current_stage = 5
				fader._fade_out()

func on_fade_finish(anim):
	if anim == "fade_out":
		get_tree().change_scene("res://src/UserInterface/Loading/Loading.tscn")





func _on_BAckMainMenu_pressed():
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
