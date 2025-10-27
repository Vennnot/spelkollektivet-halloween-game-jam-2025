class_name Peanut
extends RigidBody2D

var move_speed := 600.0
var parent_direction := Vector2.RIGHT


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	linear_velocity = parent_direction * move_speed


func destroy()->void:
	queue_free()
