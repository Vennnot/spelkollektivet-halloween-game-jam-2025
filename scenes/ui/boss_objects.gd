class_name BossObjects
extends Control

@onready var item_1: TextureRect = %Item1
@onready var item_2: TextureRect = %Item2
@onready var item_3: TextureRect = %Item3
@onready var item_4: TextureRect = %Item4
@onready var item_5: TextureRect = %Item5
@onready var item_6: TextureRect = %Item6

var item_array : Array[TextureRect]

func _ready() -> void:
	item_array.append(item_1)
	item_array.append(item_2)
	item_array.append(item_3)
	item_array.append(item_4)
	item_array.append(item_5)
	item_array.append(item_6)
	
	for t in item_array:
		t.texture = null


func fill_next_item_slot(texture:Texture):
	for t in item_array:
		if t.texture == null:
			t.texture = texture
			return
