class_name DistanceMovementComponent
extends MovementComponent

@export var move_speed := 450.0
@export var desired_distance := 500.0
@export var smoothing := 15.0  # Higher = snappier, lower = smoother

func _ready() -> void:
	pass

func calculate_velocity(target_position: Vector2, delta: float, distance: float, current_velocity: Vector2) -> Vector2:
	var direction: Vector2 = (target_position - global_position).normalized()
	var distance_error := distance - desired_distance
	
	var desired_velocity :Vector2= Vector2.ZERO
	# Dead zone to prevent jittering
	if abs(distance_error) < 10.0:
		return current_velocity.lerp(desired_velocity, smoothing * delta)
	
	# Proportional speed based on distance error (closer to target distance = slower)
	var speed_multiplier :float= clamp(abs(distance_error) / desired_distance, 0.1, 1.0)
	var target_speed :float= move_speed * speed_multiplier
	
	# Determine direction (toward or away from target)
	var move_direction := direction if distance_error > 0 else -direction
	desired_velocity = move_direction * target_speed
	
	# Smooth interpolation
	return current_velocity.lerp(desired_velocity, smoothing * delta)
