class_name Explosion
extends Node2D

@onready var damage_area: Area2D = %DamageArea

func _ready() -> void:
	damage_area.area_entered.connect(_on_area_entered)


func _on_area_entered(other_area:Area2D):
	if other_area.get_parent() is Player:
		other_area.get_parent().health_component.damage(1)
	queue_free()
