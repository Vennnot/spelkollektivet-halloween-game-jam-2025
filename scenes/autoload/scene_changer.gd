extends CanvasLayer

@onready var color_rect: ColorRect = %ColorRect

func go_to_main():
	var tween := create_tween()
	tween.tween_property(color_rect,"material:shader_parameter/progress",1,2)
	tween.tween_property(color_rect,"material:shader_parameter/progress",0,1)
	await tween.step_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
