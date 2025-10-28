class_name Door
extends Node2D

@onready var area_2d: Area2D = $Area2D

@export var connected_door:Door
var unlocked : bool = true :
	set(value):
		unlocked = value

func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)
	area_2d.area_exited.connect(_on_area_exited)
	if not connected_door:
		queue_free()


func room_finished():
	unlocked = true
	area_2d.monitoring = true


func room_started():
	unlocked = false
	area_2d.monitoring = false


func _on_area_entered(other_area:Area2D)->void:
	var parent := other_area.get_parent()
	if parent is Player and unlocked:
		connected_door.area_2d.monitoring = false
		parent.global_position = connected_door.area_2d.global_position
		Events.room_changed.emit(connected_door.get_parent().get_parent())

func _on_area_exited(other_area:Area2D)->void:
	var parent := other_area.get_parent()
	if parent is Player and unlocked:
		area_2d.monitoring = true
