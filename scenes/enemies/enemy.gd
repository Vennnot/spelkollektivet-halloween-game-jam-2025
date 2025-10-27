class_name Enemy
extends RigidBody2D

@onready var health_component: HealthComponent = %HealthComponent

@onready var hurt_box_area: Area2D = %HurtBoxArea


func _ready() -> void:
	hurt_box_area.area_entered.connect(_on_area_entered)
	health_component.died.connect(_on_death)


func _on_area_entered(other_area:Area2D)->void:
	var node :Node= other_area.get_parent()
	if node is Peanut:
		health_component.damage(1)
		node.destroy()


func _on_death()->void:
	queue_free()
