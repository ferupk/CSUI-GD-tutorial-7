extends Area3D

var death_screen = load("res://scenes/DeathMenu.tscn")


func _on_body_entered(body: Node3D) -> void:
	if body.get_name() == "Player":
		body.kill()
		
		# Show death screen
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		add_child(death_screen.instantiate())
		
		# Prevent further triggers
		set_monitoring(false)
