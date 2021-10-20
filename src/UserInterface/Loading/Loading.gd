extends Control

onready var fader = $Fader
onready var image_loading = $Fader/ImageLoading
onready var label_tip = $Fader/ImageLoading/BackgroundTip/Tip

var next_stage

func _ready():
	fader.connect("fade_finish", self, "on_fade_finish")
	var image_load1 = load("res://assets/Loading/Loading1.png")
	var image_load2 = load("res://assets/Loading/Loading2.png")
	var image_load3 = load("res://assets/Loading/Loading3.png")
	var image_load4 = load("res://assets/Loading/Loading4.png")
	var image_load5 = load("res://assets/Loading/Loading5.png")
	MenuBacksound.stop()
	
	if Utility.current_stage == 1:
		image_loading.texture = image_load1
		label_tip.text = "Lindungi diri dari virus yang sedang berkecamuk diluar sana dengan menggunakan masker sebagai pencegahan"
		next_stage = "res://src/Game/Stage1/Stage1.tscn"
	elif Utility.current_stage == 2:
		image_loading.texture = image_load2
		label_tip.text = "Kumpulkan alat-alat yang kamu butuhkan saat pembelajaran dalam jaringan"
		next_stage = "res://src/Game/Stage2/Stage2.tscn"
	elif Utility.current_stage == 3:
		image_loading.texture = image_load3
		label_tip.text = "Cari handsanitizer untuk membersihkan tangan dari virus-virus yang menempel ditangan"
		next_stage = "res://src/Game/Stage3/Stage3.tscn"
	elif Utility.current_stage == 4:
		image_loading.texture = image_load4
		label_tip.text = "Jauhi kerumunan untuk mencegah penularan virus"
		next_stage = "res://src/Game/Stage4/Stage4.tscn"
	elif Utility.current_stage == 5:
		image_loading.texture = image_load5
		label_tip.text = "Cuci tangan setiap hari untuk mnenghilangkan kuman yang ada ditangan mu"
		next_stage = "res://src/Game/Stage5/Stage5.tscn"
	fader._fade_in()

func _on_TimerLoad_timeout():
	fader._fade_out()

func on_fade_finish(anim):
	if anim == "fade_out":
		get_tree().change_scene(next_stage)
