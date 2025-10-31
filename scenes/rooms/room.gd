class_name Room
extends Node2D

const CHASE_ENEMY = preload("uid://d0hl3bf6323tt")

@onready var camera_pos: Marker2D = %CameraPos
@export var enemy_spawn_pos : Array[Marker2D]
@export var room_complete := false
@export var drops_item := true

func _ready() -> void:
	if room_complete:
		for d in $Doors.get_children():
			if d is Door:
				d.room_finished()


func start():
	await get_tree().create_timer(1.5).timeout
	if enemy_spawn_pos.is_empty():
		room_complete = true
	if room_complete:
		for d in $Doors.get_children():
			if d is Door:
				d.room_finished()
		return
	for pos in enemy_spawn_pos:
		var enemy_scene :PackedScene= EnemySpawner.fetch_random_enemy()
		var enemy:Enemy= enemy_scene.instantiate()
		add_child(enemy)
		enemy.global_position = pos.global_position
		enemy.health_component.died.connect(
	func(): call_deferred("check_if_room_done")
)


func check_if_room_done():
	for c in get_children():
		if c is Enemy:
			if not c.health_component.health_depleted:
				return
	room_complete = true
	if not drops_item:
		return
	drops_item = false
	var main :Main= get_tree().get_first_node_in_group("main")
	var item_to_spawn :ItemResource= main.items_to_spawn.pop_front()
	var item_scene :Item= load("uid://dekltjjwowiir").instantiate()
	get_tree().get_first_node_in_group("entities").add_child(item_scene)
	item_scene.resource = item_to_spawn
	item_scene.update_visuals()
	item_scene.global_position = camera_pos.global_position
	
	for d in $Doors.get_children():
		if d is Door:
			d.room_finished()
