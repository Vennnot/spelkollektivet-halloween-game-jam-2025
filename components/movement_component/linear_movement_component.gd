class_name LinearMovementComponent
extends MovementComponent

@export_category("Speed")
@export var base_slow_speed := 500.0
@export var base_normal_speed := 700.0
@export var base_max_speed := 900.0
@export var acceleration := 50

var slow_speed := base_slow_speed
var normal_speed := base_normal_speed
var max_speed := base_max_speed

@export_category("Distance")
@export var min_distance := 30.0
@export var mid_distance := 165.0
@export var max_distance := 300.0


func _ready() -> void:
	super._ready()
	slow_speed = base_slow_speed
	normal_speed = base_normal_speed
	max_speed = base_max_speed


func get_next_position(target_position:Vector2, delta:float, distance:float, current_velocity:Vector2)->Vector2:
	var direction: Vector2 = (target_position - global_position).normalized()
	var adjusted_speed: float
	if distance > mid_distance:
		# Lerp between base_max_speed and base_normal_speed
		adjusted_speed = lerp(max_speed, normal_speed, clamp((distance - mid_distance) / (max_distance - mid_distance), 0.0, 1.0))
	else:
		# Lerp between slow_speed and normal_speed
		adjusted_speed = lerp(slow_speed, normal_speed, clamp((distance - min_distance) / (mid_distance - min_distance), 0.0, 1.0))
	return direction * adjusted_speed * delta


func speed_boost(amount:float)->void:
	base_slow_speed += amount
	base_normal_speed += amount
	base_max_speed += amount
	print("base speed is now: %s" % base_normal_speed)
