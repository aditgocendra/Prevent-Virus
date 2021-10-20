extends Node2D

onready var second_label = $InterfeLayer/WoodFrameTimer/HContainer/Second
onready var countdown = $CountdownStage
onready var time_left = 59
onready var value_mask = $InterfeLayer/WoodFrameMask/HContainer/Value

export var limit_screen_right : int = 0
export var limit_screen_bottom : int = 0

onready var player = $Player
onready var data = Database.loadData()


func _ready():
	Utility.connect("pickup_mask", self, "change_value_mask")
	second_label.text = str(time_left)
	value_mask.text = str(Utility.mask_pickup)
	
	$InterfeLayer/IntroStage.set_intro_stage("Kumpulkan tiga masker dalam waktu kurang dari tiga puluh detik", load("res://assets/IntroStage/MaskIntro.png"))
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
		

func change_value_mask():
	value_mask.text = str(Utility.mask_pickup)
	if Utility.mask_pickup == 3:
		
		if time_left >= 30:
			$InterfeLayer/EndStageFrame.max_star = 3
		elif time_left < 30 and time_left > 15:
			$InterfeLayer/EndStageFrame.max_star = 2
		else : $InterfeLayer/EndStageFrame.max_star = 1
		
		$InterfeLayer/EndStageFrame.show()
		$InterfeLayer/EndStageFrame.play_win_frame()
		
		if data["stage_open"] < 5:
			data["stage_open"] += 1
			Database.save_data(data)
		get_tree().paused = true
		

