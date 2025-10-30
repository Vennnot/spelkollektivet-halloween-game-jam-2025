class_name End
extends CanvasLayer

@onready var intro: Label = %IntroLabel
var transitioned := false

func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(intro,"visible_ratio",1,10)


func _process(delta: float) -> void:
	next_scene()


func next_scene():
	if Input.is_action_just_pressed("restart") and not transitioned:
		transitioned = true
		SceneChanger.go_to_start()
