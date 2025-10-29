class_name Main
extends Node

var active_room : Node

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("restart"):
		SceneChanger.go_to_main()
