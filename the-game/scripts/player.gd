extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -600.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$DustParticles.emitting = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left ", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func die() -> void:
	print("BAM! Hit!")
	# Access the Camera2D child directly from the Player node
	$Camera2D.apply_shake(10.0)
	
	# Wait for a split second (0.2 seconds) so Peter can actually see the screen shake!
	await get_tree().create_timer(0.2).timeout
	
	# Reset the level
	get_tree().reload_current_scene()
