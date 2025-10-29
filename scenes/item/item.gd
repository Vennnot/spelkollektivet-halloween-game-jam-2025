class_name Item
extends Node2D

@onready var sprite: Sprite2D = %Sprite

var resource : ItemResource :
	set(value):
		resource = value
		if value ==  null:
			return
		update_visuals()

func _ready() -> void:
	resource = load("res://resources/items/item_bubblegum.tres")


func update_visuals():
	sprite.texture = resource.sprite


func despawn():
	queue_free()
