extends Control

onready var fader = $Fader
onready var next_scene = ""

func _ready():
	fader.connect("fade_finish", self, "on_fade_finish")
	fader._fade_in()


func on_fade_finish(anim):
	if anim == "fade_in":
		$AnimationPlayer.play("start")
	else: get_tree().change_scene(next_scene)


func _on_Play_pressed():
	next_scene = "res://src/UserInterface/Stage/Stage.tscn"
	fader._fade_out()
