extends Area3D

@export var scene_name := "Level1"

@onready var animation: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node3D) -> void:
	if body.get_name() == "Player":
		body.disable_movement()
		animation.play("Flag Raise")
		await animation.animation_finished
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().call_deferred("change_scene_to_file", "res://scenes/" + scene_name + ".tscn")
