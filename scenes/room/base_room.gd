class_name BaseRoom extends Node2D

@export var hostile_node : Node
@export var exit_door: Area2D
@export var player_spawn: Marker2D

var finished := false

func connect_signals():
	pass

func _ready() -> void:
	connect_signals()
	exit_door.monitorable = false

func _process(delta: float) -> void:
	if !finished and hostile_node.get_child_count() == 0:
		end_room()

func start_room():
	pass
	
func end_room():
	print("End of the room")
	finished = true
	exit_door.monitorable = true
