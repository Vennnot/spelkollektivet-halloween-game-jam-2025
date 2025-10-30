class_name Puddle
extends Node2D

@onready var lifetime_timer: Timer = %LifetimeTimer
@onready var damage_area: Area2D = %DamageArea
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sprite: Sprite2D = %Sprite
const PUDDLES_2 = preload("uid://d0e44w4cqhx8g")
const PUDDLES_3 = preload("uid://cq0312bix1iyn")
const PUDDLES = preload("uid://b3g3uo6fo655v")

func _ready() -> void:
	lifetime_timer.timeout.connect(despawn)
	damage_area.area_entered.connect(_on_area_entered)
	animation_player.play_backwards("despawn")
	sprite.texture = [PUDDLES,PUDDLES_2,PUDDLES_3].pick_random()


func _on_area_entered(other_area:Area2D):
	var parent := other_area.get_parent()
	if parent is Enemy:
		parent.health_component.damage(1)


func despawn():
	animation_player.play("despawn")
	await animation_player.animation_finished
	queue_free()
