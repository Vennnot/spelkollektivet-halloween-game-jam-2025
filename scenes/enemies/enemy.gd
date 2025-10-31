class_name Enemy
extends CharacterBody2D

const PICKUP_HEALTH = preload("uid://c7w0femtixw5y")

@export var explosion : PackedScene = load("res://scenes/enemies/bomb_enemy/explosion.tscn")
@export var health_component: HealthComponent
@export var movement_component: MovementComponent
@export var hitbox: HitboxComponent

@onready var sprite: Sprite2D = %Sprite
@onready var visuals: Node2D = %Visuals
@onready var ghost: Sprite2D = %Ghost
@onready var item: Sprite2D = %Item

var defeated := false
var player : Player
var bullet_sprite : Sprite2D
var spawned := false

func _ready() -> void:
	health_component.died.connect(_on_death)
	health_component.damaged.connect(func(): 
		var tween :=create_tween()
		tween.tween_property(visuals,"modulate",Color.RED,0.2)
		tween.tween_property(visuals,"modulate",Color.WHITE,0.2)
	)
	visuals.hide()
	player = get_tree().get_first_node_in_group("player")
	await get_tree().create_timer(0.01).timeout
	spawn()


func spawn():
	if self is BossEnemy:
		visuals.show()
		spawned = true
		return
	
	visuals.show()
	var spawn_pos := global_position
	global_position = Vector2(spawn_pos.x, spawn_pos.y - 500)
	var shader := sprite.material as ShaderMaterial
	shader.set_shader_parameter("maxLineWidth",0)
	shader.set_shader_parameter("minLineWidth",0)
	ghost.show()
	item.show()

	var tween := create_tween()
	tween.tween_property(self, "global_position", Vector2(spawn_pos.x, spawn_pos.y + 10), 1) 
	await tween.finished

	var tweene := create_tween()
	tweene.set_parallel(true)
	tweene.tween_property(item, "self_modulate", Color.TRANSPARENT, 1)
	tweene.tween_property(ghost, "self_modulate", Color.TRANSPARENT, 1)
	tweene.tween_property(self, "global_position", Vector2(spawn_pos.x, spawn_pos.y), 1)  
	await tweene.finished
	AudioManager.play("enemy_spawn")
	shader.set_shader_parameter("maxLineWidth",10)
	shader.set_shader_parameter("minLineWidth",5)
	spawned = true


func _physics_process(delta: float) -> void:
	if defeated:
		return
	
	if not spawned:
		return
	
	if not player:
		return
	
	var distance := global_position.distance_to(player.global_position)
	
	velocity = movement_component.calculate_velocity(player.global_position, delta, distance, velocity)
	move_and_slide()


func bullet_explosion():
	var pomegranate_timer := get_tree().create_timer(3)
	pomegranate_timer.timeout.connect(_on_pomegranate_timer_timeout)
	var tween := create_tween()
	tween.tween_property(bullet_sprite, "scale",Vector2(1.5,1.5),3)

func _on_pomegranate_timer_timeout():
	health_component.damage(10)
	var expats :Explosion=explosion.instantiate()  
	get_tree().get_first_node_in_group("entities").add_child(expats)
	expats.global_position = global_position
	expats.player = false
	bullet_sprite.queue_free()

func _on_death()->void:
	visuals.modulate = Color.WHITE
	sprite.modulate = Color.WHITE
	visuals.self_modulate = Color.WHITE
	sprite.self_modulate = Color.WHITE
	Events.enemy_died.emit(sprite.texture)
	defeated = true
	spawn_health()
	AudioManager.play("enemy_death")
	queue_free()

func spawn_health():
	if randf_range(0,1)>0.5:
		return
	
	var pickup := PICKUP_HEALTH.instantiate()
	var entities_node = get_tree().get_first_node_in_group("entities")
	entities_node.call_deferred("add_child", pickup)
	pickup.global_position = global_position
