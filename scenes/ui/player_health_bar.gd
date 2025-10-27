class_name PlayerHealthBar extends Control

@onready var heart_container: HBoxContainer = %HeartContainer
@export var heart_texture: Texture2D

func _ready() -> void:
	Events.player_health_changed.connect(on_player_health_changed)

func on_player_health_changed(new_value: int):
	var index = 0
	for icon : TextureRect in heart_container.get_children():
		icon.visible = index >= new_value
