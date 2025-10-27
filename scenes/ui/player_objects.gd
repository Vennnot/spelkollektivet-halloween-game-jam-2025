class_name PlayerObjects
extends Control

@onready var item_1: TextureRect = %Item1
@onready var item_2: TextureRect = %Item2
@onready var item_3: TextureRect = %Item3

func _ready() -> void:
	Events.item_changed.connect(_on_item_changed)



func _on_item_changed(slot:int,texture:Texture):
	match slot:
		1:
			item_1.texture = texture
		2:
			item_2.texture = texture
		3:
			item_3.texture = texture
