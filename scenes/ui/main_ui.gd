class_name MainUI
extends CanvasLayer

@onready var game_over: Control = %GameOver

func _ready() -> void:
	Events.game_over.connect(func():game_over.show())
