class_name Room
extends Node2D

const CHASE_ENEMY = preload("uid://d0hl3bf6323tt")

@onready var camera_pos: Marker2D = %CameraPos
@export var enemy_spawn_pos : Array[Marker2D]
@export var room_complete := false

func start():
	if room_complete:
		for d in $Doors.get_children():
			if d is Door:
				d.room_finished()
		return
	for pos in enemy_spawn_pos:
		var enemy:Enemy= CHASE_ENEMY.instantiate()
		add_child(enemy)
		enemy.global_position = pos.global_position
		enemy.health_component.died.connect(check_if_room_done)


func check_if_room_done():
	for c in get_children():
		if c is Enemy:
			if not c.health_component.health_depleted:
				return
	room_complete = true
	for d in $Doors.get_children():
		if d is Door:
			d.room_finished()
