class_name Camera
extends Camera2D

func _ready() -> void:
	Events.room_changed.connect(_on_room_changed)


func _on_room_changed(room: Room):
	var target_pos := room.camera_pos.global_position
	
	var tween := create_tween()
	tween.tween_property(self, "global_position", target_pos, 0.6).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
