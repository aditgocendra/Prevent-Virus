extends Node2D

onready var secone_label = $InterfeLayer/WoodFrameTimer/HContainer/Second
onready var countdown = $CountdownStage
onready var time_left = 59
onready var latop = $InterfeLayer/WoodFrameMask/ObjectiveContainer/Laptop
onready var book = $InterfeLayer/WoodFrameMask/ObjectiveContainer/Book
onready var pen = $InterfeLayer/WoodFrameMask/ObjectiveContainer/Pen

export var limit_screen_right : int = 0
export var limit_screen_bottom : int = 0
onready var data = Database.loadData()

func _ready():
	Utility.connect("pick_up_tool", self, "new_tool_pick")
	secone_label.text = str(time_left)
	latop.modulate = Color(1,1,1, 0.30)
	book.modulate = Color(1,1,1, 0.30)
	pen.modulate = Color(1,1,1, 0.30)
	
	$InterfeLayer/IntroStage.set_intro_stage("Kumpulkan Alat-alat pembelajaran daring kurang dari tiga puluh detik", load("res://assets/IntroStage/Tools.png"))
	get_tree().paused = true
	
func _on_CountdownStage_timeout():
	if time_left > 0:
		time_left -= 1
		secone_label.text = str(time_left)
	else:
		countdown.stop()
		$InterfeLayer/EndStageFrame.show()
		$InterfeLayer/EndStageFrame.play_lose_frame()
		get_tree().paused = true
		

func new_tool_pick():
	var tool_pick = Utility.tool_pickup
	
	if tool_pick[0] == 1:
		latop.modulate = Color(1,1,1,1)
		
	if tool_pick[1] == 1:
		book.modulate = Color(1,1,1,1)
		
	if tool_pick[2] == 1:
		pen.modulate = Color(1,1,1,1)
		
	if not 0 in tool_pick:
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
	
