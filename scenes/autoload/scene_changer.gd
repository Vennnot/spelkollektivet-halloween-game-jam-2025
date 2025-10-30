extends CanvasLayer

@onready var color_rect: ColorRect = %ColorRect

func go_to_main():
	var tween := create_tween()
	tween.tween_property(color_rect,"material:shader_parameter/progress",1,0.5)
	tween.tween_property(color_rect,"material:shader_parameter/progress",0,0.5)
	await tween.step_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func go_to_end():
	var tween := create_tween()
	tween.tween_property(color_rect,"material:shader_parameter/progress",1,0.5)
	tween.tween_property(color_rect,"material:shader_parameter/progress",0,0.5)
	await tween.step_finished
	get_tree().change_scene_to_file("uid://b41mjqbto3rvw")


func go_to_start():
	var tween := create_tween()
	tween.tween_property(color_rect,"material:shader_parameter/progress",1,0.5)
	tween.tween_property(color_rect,"material:shader_parameter/progress",0,0.5)
	await tween.step_finished
	get_tree().change_scene_to_file("uid://cxhva57j2pgca")
