class_name PickupHealth
extends Pickup

@onready var sprite: Sprite2D = %Sprite

func despawn()->void:
	Events.player_health_added.emit(sprite.texture)
	queue_free()
