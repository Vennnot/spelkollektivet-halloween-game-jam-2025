class_name PlayerHealthBar extends Control

const HEART := preload("uid://bpv3hmigfp77f")

@onready var heart_container: HBoxContainer = %HeartContainer
@export var heart_texture: Texture2D

func _ready() -> void:
	
	Events.player_health_changed.connect(on_player_health_changed)
	Events.player_health_added.connect(on_player_health_added)

func set_healthbar():
	pass

func on_player_health_changed(new_value: int):
	if new_value >= get_health_containers().size():
		return
	var container :TextureRect= heart_container.get_children().pop_front()
	container.queue_free()


func on_player_health_added(texture: Texture = HEART):
	var heart := TextureRect.new()
	heart_container.add_child(heart)
	heart.texture = texture
	

func get_health_containers()->Array[Node]:
	return heart_container.get_children() as Array[Node]
