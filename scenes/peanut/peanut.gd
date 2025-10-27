class_name Peanut
extends CharacterBody2D

var move_speed := 600.0
var parent_direction := Vector2.RIGHT


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	velocity = parent_direction * move_speed
	move_and_slide()


func destroy()->void:
	queue_free()
