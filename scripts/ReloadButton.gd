extends LinkButton

@export var scene_name := "Level1"


func _on_pressed() -> void:
	get_tree().call_deferred("reload_current_scene")
