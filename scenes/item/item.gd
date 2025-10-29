class_name Item
extends Node2D

signal taken_away

@onready var sprite: Sprite2D = %Sprite
@onready var ghost: Sprite2D = %Ghost

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


func take_away():
	ghost.show()
	var tween := create_tween()
	tween.tween_property(self,"global_position",Vector2(global_position.x,-600),2)
	await tween.finished
	taken_away.emit()


func despawn():
	queue_free()
