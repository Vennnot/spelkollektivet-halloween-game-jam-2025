class_name RandomMovementComponent
extends MovementComponent

@export_category("Speed")
@export var move_speed := 250.0
@export var direction_change_interval := 3.0

var random_direction := Vector2.ZERO
var timer := 0.0

func _ready() -> void:
	_pick_random_direction()

func calculate_velocity(target_position: Vector2, delta: float, distance: float, current_velocity: Vector2) -> Vector2:
	timer += delta
	if timer >= direction_change_interval:
		_pick_random_direction()
		timer = 0.0
	
	var desired_velocity := random_direction * move_speed
	var acceleration := 5.0
	var lerp_factor :float= clamp(acceleration * delta, 0.0, 1.0)
	current_velocity = current_velocity.lerp(desired_velocity, lerp_factor)
	
	return current_velocity

func _pick_random_direction() -> void:
	var angle := randf() * TAU
	random_direction = Vector2(cos(angle), sin(angle))
