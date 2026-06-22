extends Area2D

@export var boost_force : float = -1200.0

func _on_body_entered(body: Node2D) -> void:
	if "velocity" in body: 
		body.velocity.y = boost_force
		if $AnimatedSprite2D.sprite_frames.has_animation("bounce"):
			$AnimatedSprite2D.play("bounce") # Feedback
		print("Woosh! Super Jump!")
