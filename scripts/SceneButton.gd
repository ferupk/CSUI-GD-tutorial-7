extends LinkButton

@export var scene_name := "Level1"


func _on_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/" + scene_name + ".tscn")
