extends Node

var db_path = "user://database.json"
#var db_path = "res://src/Singleton/database.json"
var _file
var json_data

var default_data = {
  "game_settings": {
	"sound": {
	  "backsound": true,
	  "sound_fx": true
	}
  },
  "stage_open": 1
}

func loadData():
	_file = File.new()
		
	if not _file.file_exists(db_path):
		save_data(default_data)
		return default_data
	else:
		_file.open(db_path, File.READ)
		
		json_data = parse_json(_file.get_as_text())
		
		if json_data.size() > 0:
			return json_data


func save_data(new_data):
	_file = File.new()
	
	_file.open(db_path, File.WRITE)
	_file.store_line(to_json(new_data))
	_file.close()
