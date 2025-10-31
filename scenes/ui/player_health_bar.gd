class_name PlayerHealthBar extends Control

const HEART = preload("uid://b1tprn422ubsc")
const TILE_001 = preload("uid://cwo3cwinhk03")
const TILE_002 = preload("uid://c4ss7lurdpq0p")


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
	var container :TextureRect= heart_container.get_children().pop_back()
	container.texture = TILE_001
	await get_tree().create_timer(0.25).timeout
	container.texture = TILE_002
	await get_tree().create_timer(0.25).timeout
	container.queue_free()


func on_player_health_added(texture: Texture = HEART):
	var heart := TextureRect.new()
	heart_container.add_child(heart)
	heart.texture = texture
	

func get_health_containers()->Array[Node]:
	return heart_container.get_children() as Array[Node]
