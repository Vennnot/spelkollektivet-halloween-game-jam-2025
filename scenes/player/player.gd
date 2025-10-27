class_name Player
extends CharacterBody2D

const PLAYER_BULLET = preload("uid://cluutx5sqp8ns")

@export var move_speed: float = 400.0
@export var acceleration: float = 1100.0
@export var friction: float = 1100.0

var last_direction := Vector2.RIGHT


@onready var health_component: HealthComponent = $Components/HealthComponent

@onready var attack_timer: Timer = $AttackTimer
@onready var item_area: Area2D = %ItemArea

func _connect_health_signals():
	health_component.healed.connect(on_health_changed)
	health_component.damaged.connect(on_health_changed)

func _ready() -> void:
	health_component.died.connect(_on_death)
	item_area.area_entered.connect(_on_item_area_entered)
	_connect_health_signals()
	
	await get_tree().create_timer(2).timeout
	health_component.damage(1)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		shoot()
		
	if Input.is_action_pressed("item_1"):
		pass
	
	if Input.is_action_pressed("item_2"):
		pass
	
	if Input.is_action_pressed("item_3"):
		pass
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	
	if input_dir.length() > 0:
		last_direction = input_dir
		# Accelerate towards max speed
		velocity = velocity.move_toward(input_dir * move_speed, acceleration * delta)
	else:
		# Apply friction when no input
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()


func shoot():
	if not attack_timer.is_stopped():
		return
	
	attack_timer.start()
	var peanut : BaseBullet = PLAYER_BULLET.instantiate()
	get_tree().get_first_node_in_group("entities").add_child(peanut)
	peanut.global_position = global_position
	peanut.throw(last_direction, 600., 1)


func _on_death():
	pass


func _on_item_area_entered(other_area:Area2D)->void:
	var parent :Node = other_area.get_parent()
	if parent is Pickup:
		parent.despawn()
		health_component.heal(1)


func on_health_changed():
	Events.player_health_changed.emit(health_component.health)
