class_name BaseBullet extends CharacterBody2D

var launched = true

@onready var hurtbox: HurtboxComponent = %HurtboxComponent

func throw(direction: Vector2, move_speed: float, damage: int):
	velocity = direction * move_speed
	hurtbox.damage = damage
	launched = true 

func _physics_process(delta: float) -> void:
	if launched:
		move_and_slide()
		
		if get_last_slide_collision() != null:
			destroy()

func destroy():
	queue_free()
