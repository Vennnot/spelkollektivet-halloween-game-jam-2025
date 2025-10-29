class_name Player
extends CharacterBody2D


const ITEM := preload("res://scenes/item/item.tscn")

@export var move_speed: float = 400.0
@export var base_speed : float = 400.0
@export var slow_speed : float = 200.0
@export var acceleration: float = 1500.0
@export var friction: float = 1500.0

var last_direction := Vector2.RIGHT
var on_item :Item= null
var items : Array[ItemResource] = [null,null,null]

var amount_per_shot := 1
var time_between_shots := 0.05
var number_of_shots := 1


@onready var health_component: HealthComponent = $Components/HealthComponent
@onready var attack_timer: Timer = $AttackTimer
@onready var item_area: Area2D = %ItemArea
@onready var shooter: Shooter = %Shooter
@onready var invul_timer: Timer = %InvulTimer

func _connect_health_signals():
	health_component.healed.connect(on_health_changed)
	health_component.damaged.connect(on_health_changed)

func _ready() -> void:
	invul_timer.timeout.connect(_on_invul_timer_timeout)
	health_component.died.connect(_on_death)
	health_component.damaged.connect(_on_damaged)
	item_area.area_entered.connect(_on_item_area_entered)
	item_area.area_exited.connect(_on_item_area_exited)
	_connect_health_signals()


func _on_invul_timer_timeout():
	health_component.disabled=false
	for area in item_area.get_overlapping_areas():
		if area.get_parent() is Spikes:
			health_component.damage(1)


func _on_damaged():
	invul_timer.start()
	health_component.disabled = true


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		shoot()
		
	if Input.is_action_pressed("item_1"):
		swap_items(1)
	
	if Input.is_action_pressed("item_2"):
		swap_items(2)
	
	if Input.is_action_pressed("item_3"):
		swap_items(3)
	
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
	shooter.shoot(last_direction, amount_per_shot, time_between_shots,number_of_shots,items)



func swap_items(slot:int)->void:
	if not on_item:
		return
	
	var previous_item := items[slot]
	items[slot] = on_item.resource
	Events.item_changed.emit(slot,on_item.resource.sprite)
	on_item.queue_free()
	check_items()
	
	if previous_item == null:
		return
	
	var item :Item= ITEM.instantiate()
	get_tree().get_first_node_in_group("entities").add_child(item)
	item.global_position = global_position
	item.resource = previous_item


func check_items():
	number_of_shots = 1
	amount_per_shot = 1
	for item in items:
		if not item:
			continue
		elif item.id == "watermelon":
			number_of_shots = 3
		elif item.id == "chestnut":
			amount_per_shot = 2


func _on_death():
	Events.game_over.emit()
	queue_free()


func _on_item_area_entered(other_area:Area2D)->void:
	var parent :Node = other_area.get_parent()
	if parent is Pickup:
		parent.despawn()
		health_component.heal(1)
	elif parent is Item:
		on_item = parent
	elif parent is Web:
		move_speed = slow_speed
	elif parent is Spikes:
		health_component.damage(1)
	elif parent is Bullet:
		health_component.damage(1)
		parent.destroy()
	elif parent is Enemy:
		health_component.damage(1)


func _on_item_area_exited(other_area:Area2D)->void:
	var parent :Node = other_area.get_parent()
	if parent is Item:
		on_item = null
	elif parent is Web:
		move_speed = base_speed
	

func on_health_changed():
	Events.player_health_changed.emit(health_component.health)
