class_name Enemy
extends CharacterBody2D

const KITSUGIRI := preload("uid://brou6b3nhxkx8")

@export var health_component: HealthComponent
@export var movement_component: MovementComponent
@export var hitbox: HitboxComponent

@onready var sprite: Sprite2D = %Sprite
@onready var kitsugiri_timer: Timer = %KitsugiriTimer
@onready var visuals: Node2D = %Visuals

var defeated := false
var kitsugiri_shader : Shader
var player : Player

func _ready() -> void:
	hitbox.hitted.connect(_on_hit)
	health_component.died.connect(_on_death)
	kitsugiri_timer.timeout.connect(_on_kitsugiri_timer_timeout)
	
	kitsugiri_shader = KITSUGIRI.duplicate()
	
	await get_tree().create_timer(0.1).timeout
	
	player = get_tree().get_first_node_in_group("player")
	


func _physics_process(delta: float) -> void:
	if defeated:
		return
	
	if not player:
		return
	
	var distance := global_position.distance_to(player.global_position)
	
	velocity = movement_component.calculate_velocity(player.global_position, delta, distance, velocity)
	move_and_slide()

func _on_hit(hurtbox: HurtboxComponent)->void:
	health_component.damage(hurtbox.damage)
	hurtbox.queue_free()


func _on_death()->void:
	visuals.modulate = Color.WHITE
	sprite.modulate = Color.WHITE
	visuals.self_modulate = Color.WHITE
	sprite.self_modulate = Color.WHITE
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = kitsugiri_shader
	var shader := sprite.material as ShaderMaterial
	shader.set_shader_parameter("shine_size",10)
	shader.set_shader_parameter("shine_intensity",1)
	defeated = true
	kitsugiri_timer.start()


func _on_kitsugiri_timer_timeout()->void:
	var shader := sprite.material as ShaderMaterial
	var intensity_value : float= shader.get_shader_parameter("shine_intensity")
	
	#TODO vary size?
	var tween :=create_tween()
	tween.tween_property(sprite,"material:shader_parameter/shine_intensity",clamp(intensity_value+randf_range(-0.5,0.5),2,3.5),0.6)
	kitsugiri_timer.start()
	queue_free()
