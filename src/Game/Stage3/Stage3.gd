extends Node2D

onready var second_label = $InterfeLayer/WoodFrameTimer/Second
onready var countdown = $CountdownStage
onready var time_left = 90
onready var value_sanitizer = $InterfeLayer/WoodFrameSanitizer/HBoxContainer/Value

export var limit_screen_right : int = 0
export var limit_screen_bottom : int = 0
onready var data = Database.loadData()

func _ready():
	Utility.connect("pick_sanitizer", self, "on_pick_sanitizer")
	Utility.connect("object_crash", self, "on_crash_object")
	second_label.text = str(time_left)
	value_sanitizer.text = str(Utility.sanitizer_pick)
	
	$InterfeLayer/IntroStage.set_intro_stage("Kumpulkan Tiga Sanitizer kurang dari enam puluh detik", load("res://assets/IntroStage/SanitizerIntro.png"))
	get_tree().paused = true

func _on_CountdownStage_timeout():
	if time_left > 0:
		time_left -= 1
		second_label.text = str(time_left)
	else:
		countdown.stop()
		$InterfeLayer/EndStageFrame.show()
		$InterfeLayer/EndStageFrame.play_lose_frame()
		get_tree().paused = true
		

func on_pick_sanitizer():
	value_sanitizer.text = str(Utility.sanitizer_pick)
	
	if Utility.sanitizer_pick == 3:
		if time_left >= 60:
			$InterfeLayer/EndStageFrame.max_star = 3
		elif time_left < 60 and time_left > 30:
			$InterfeLayer/EndStageFrame.max_star = 2
		else : $InterfeLayer/EndStageFrame.max_star = 1
		
		$InterfeLayer/EndStageFrame.show()
		$InterfeLayer/EndStageFrame.play_win_frame()
		
		if data["stage_open"] < 5:
			data["stage_open"] += 1
			Database.save_data(data)
		
		get_tree().paused = true
	
func on_crash_object():
	countdown.stop()
	$InterfeLayer/EndStageFrame.show()
	$InterfeLayer/EndStageFrame.play_lose_frame()
	get_tree().paused = true
