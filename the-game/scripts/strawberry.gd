extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

signal collected

func _on_body_entered(_body: Node2D) -> void:
	$CPUParticles2D.emitting = true # Booom! Start particle explosion
	animated_sprite_2d.play("collected")
	collected.emit()
	
	# Optionales Sound-Feedback (müssen AudioStreamPlayer2D hinzufügen):
	# $AudioStreamPlayer2D.play()
	
	call_deferred("_disable_collision")
	await get_tree().create_timer(0.5).timeout
	queue_free()
	
	
	# Wait a split second for the particles to finish blowing up before deleting the strawberry
	await get_tree().create_timer(0.5).timeout
	queue_free()
	
func _disable_collision() -> void:
	collision_shape_2d.disabled = true
