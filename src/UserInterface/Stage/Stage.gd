extends Control

onready var container_stage = $Background/BoxBackground/CotainerStage
onready var fader = $Fader

var open_stage = 1


func _ready():
	fader._fade_in()
	_stage_open()

func _stage_open():
	for i in range(open_stage):
		var child = container_stage.get_child(i)
		child.get_node("LockStage").hide()
		


func _on_StageBG1_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			print(true)


func _on_StageBG2_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
				print(true)



func _on_StageBG3_gui_input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			print(true)


func _on_StageBG4_gui_input(event):
	if event is InputEventScreenTouch:
			if event.is_pressed():
					print(true)


func _on_StageBG5_gui_input(event):
	if event is InputEventScreenTouch:
			if event.is_pressed():
					print(true)




func load_stage():
	pass


