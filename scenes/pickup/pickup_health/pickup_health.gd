class_name PickupHealth
extends Pickup

@onready var sprite: AnimatedSprite2D = %Sprite

func despawn()->void:
	Events.player_health_added.emit(sprite.sprite_frames.get_frame_texture("default",0))
	queue_free()
