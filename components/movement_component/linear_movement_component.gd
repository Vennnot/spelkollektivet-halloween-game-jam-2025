class_name LinearMovementComponent
extends MovementComponent

@export_category("Speed")
@export var move_speed := 250.0


func _ready() -> void:
	pass


func calculate_velocity(target_position: Vector2, delta: float, distance: float, current_velocity: Vector2) -> Vector2:
	var direction: Vector2 = (target_position - get_parent().get_parent().global_position).normalized()
	var desired_velocity: Vector2 = direction * move_speed
	var acceleration: float = 5.0  # lower = smoother, higher = snappier
	
	var lerp_factor: float = clamp(acceleration * delta, 0.0, 1.0)
	current_velocity = current_velocity.lerp(desired_velocity, lerp_factor)
	
	return current_velocity
