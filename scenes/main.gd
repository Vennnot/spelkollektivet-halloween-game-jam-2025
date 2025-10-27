class_name Main
extends Node

var active_room : Node

func _ready() -> void:
	pass

#region Run Manager

func start_run():
	print("Run started")


func restart_run():
	start_run()


func end_run():
	print("Run ended")
#endregion
