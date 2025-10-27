class_name Enemy
extends CharacterBody2D

const KITSUGIRI := preload("uid://brou6b3nhxkx8")

@onready var health_component: HealthComponent = %HealthComponent
@onready var sprite: Sprite2D = %Sprite
@onready var hurt_box_area: Area2D = %HurtBoxArea
@onready var kitsugiri_timer: Timer = %KitsugiriTimer

var defeated := false

func _ready() -> void:
	hurt_box_area.area_entered.connect(_on_area_entered)
	health_component.died.connect(_on_death)
	kitsugiri_timer.timeout.connect(_on_kitsugiri_timer_timeout)
	
	sprite.material.shader = null


func _process(delta: float) -> void:
	if not defeated:
		return

func _on_area_entered(other_area:Area2D)->void:
	var node :Node= other_area.get_parent()
	if node is Peanut:
		health_component.damage(1)
		node.destroy()


func _on_death()->void:
	sprite.material.shader = KITSUGIRI
	var shader := sprite.material as ShaderMaterial
	shader.set_shader_parameter("shine_size",10)
	shader.set_shader_parameter("shine_intensity",1)
	defeated = true
	kitsugiri_timer.start()


func _on_kitsugiri_timer_timeout()->void:
	var shader := sprite.material as ShaderMaterial
	var intensity_value : float= shader.get_shader_parameter("shine_intensity")
	
	var tween :=create_tween()
	tween.tween_property(sprite,"material:shader_parameter/shine_intensity",clamp(intensity_value+randf_range(-0.5,0.5),2,3.5),0.6)
	kitsugiri_timer.start()
