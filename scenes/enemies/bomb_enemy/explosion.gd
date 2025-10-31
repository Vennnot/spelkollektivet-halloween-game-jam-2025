class_name Explosion
extends Node2D

@onready var damage_area: Area2D = %DamageArea
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

var player:bool= true

func _ready() -> void:
	damage_area.area_entered.connect(_on_area_entered)
	animated_sprite_2d.animation_finished.connect(queue_free)
	AudioManager.play("enemy_explosion")

func _on_area_entered(other_area:Area2D):
	if other_area.get_parent() is Player and player:
		other_area.get_parent().health_component.damage(1)
	if other_area.get_parent() is not Player and not player:
		other_area.get_parent().health_component.damage(1)
