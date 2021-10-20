extends TextureRect

onready var desc_label = $VBoxContainer/Desc
onready var objective_texture = $ObjectiveTexture


func set_intro_stage(desc, texture_obj):
	desc_label.text = desc
	objective_texture.texture = texture_obj


func _on_SkipBtn_pressed():
	get_tree().paused = false
	self.queue_free()
