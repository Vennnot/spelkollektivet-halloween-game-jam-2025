class_name ShootEnemy
extends Enemy

@onready var shoot_timer: Timer = %ShootTimer

func _ready() -> void:
	super._ready()
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if player:
		var direction := global_position.direction_to(player.global_position)
		var target_rotation := direction.angle() +PI/2
		visuals.rotation = lerp_angle(visuals.rotation, target_rotation, 10.0 * delta)

func _on_shoot_timer_timeout()->void:
	shoot()


func shoot():
	pass
