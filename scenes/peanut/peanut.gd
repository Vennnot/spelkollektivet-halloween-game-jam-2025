class_name Peanut
extends Node2D

var move_speed := 600.0
var parent_direction := Vector2.RIGHT

func _physics_process(delta: float) -> void:
	translate(parent_direction * (move_speed * delta))

func destroy()->void:
	queue_free()
