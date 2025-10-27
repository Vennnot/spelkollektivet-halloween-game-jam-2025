class_name Player
extends CharacterBody2D

@export var move_speed: float = 10000.0

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("left","right","up","down")
	
	# Normalize diagonal movement
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()
	
	velocity = input_dir * move_speed * delta
	move_and_slide()
