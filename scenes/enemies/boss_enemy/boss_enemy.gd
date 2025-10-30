class_name BossEnemy
extends Enemy

@onready var shoot_timer: Timer = %ShootTimer
@onready var shooter: Shooter = %Shooter
var max_shots : int = 1
var spread_shot :int = 1

func _ready() -> void:
	super._ready()
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	if EnemySpawner.watermelon:
		max_shots = 3
	if EnemySpawner.chestnut:
		spread_shot = 2

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if player:
		var direction := global_position.direction_to(player.global_position)
		var target_rotation := direction.angle() +PI/2
		visuals.rotation = lerp_angle(visuals.rotation, target_rotation, 10.0 * delta)

func _on_shoot_timer_timeout()->void:
	shoot()

func shoot():
	if not player:
		return
	var direction := global_position.direction_to(player.global_position)
	shooter.shoot(direction,max_shots,0.1,spread_shot,[])


func _on_death():
	super._on_death()
	SceneChanger.go_to_end()
