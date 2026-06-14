extends Area2D

@export var boost_force : float = -1200.0

func _on_body_entered(body: Node2D) -> void:
	if "velocity" in body: 
		body.velocity.y = boost_force
		print("Woosh! Super Jump!")
