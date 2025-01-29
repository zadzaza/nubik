extends Node

const SAVE_PATH = "user://save.json"

var levels_complete: Dictionary = {
	"level1": true,
	"level2": false,
	"level3": false,
	"level4": false,
	"level5": false,
	"level6": false,
	"level7": false
}

func save_game(data: Dictionary):
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(data)
		file.store_string(json_string)
		file.close()
		print("Сохранено:", json_string)
	else:
		print("Ошибка сохранения")

func load_game() -> Dictionary:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var error = json.parse(content)
		if error == OK:
			print("Загружено:", json.data)
			return json.data
		else:
			print("Ошибка загрузки JSON")
	return {
		"level1": true,
		"level2": false,
		"level3": false,
		"level4": false,
		"level5": false,
		"level6": false,
		"level7": false
	}
