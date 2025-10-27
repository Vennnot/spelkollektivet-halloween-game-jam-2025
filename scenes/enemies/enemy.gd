class_name Enemy
extends CharacterBody2D

const KITSUGIRI := preload("uid://brou6b3nhxkx8")

@onready var health_component: HealthComponent = %HealthComponent
@onready var sprite: Sprite2D = %Sprite
@onready var hitbox: HitboxComponent = %HitboxComponent
@onready var kitsugiri_timer: Timer = %KitsugiriTimer

var defeated := false
var kitsugiri_shader : Shader

func _ready() -> void:
	hitbox.hitted.connect(_on_hit)
	health_component.died.connect(_on_death)
	kitsugiri_timer.timeout.connect(_on_kitsugiri_timer_timeout)
	
	kitsugiri_shader = KITSUGIRI.duplicate()


func _process(delta: float) -> void:
	if not defeated:
		return

func _on_hit(hurtbox: HurtboxComponent)->void:
	health_component.damage(hurtbox.damage)
	hurtbox.queue_free()


func _on_death()->void:
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
