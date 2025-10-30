class_name Shooter
extends Node2D

@export var bullet_scene :PackedScene

func _ready() -> void:
	pass


func shoot(direction:Vector2, amount_per_shot:int, time_between_shots:float, number_of_shots:int, items:Array[ItemResource]):
	if get_parent() is Enemy:
		AudioManager.play("enemy_shooting")
	var total_spread := (amount_per_shot - 1) * 10.0
	var start_angle := -total_spread / 2.0
	for j in number_of_shots:
		for i in amount_per_shot:    
			var bullet := spawn_bullet()
			var angle := start_angle + (i * 10.0)
			var bullet_direction := direction.rotated(deg_to_rad(angle))
			bullet.throw(bullet_direction, 1000, 1)
		await get_tree().create_timer(time_between_shots).timeout


func spawn_bullet()->Bullet:
	var bullet : Bullet = bullet_scene.instantiate()
	get_tree().get_first_node_in_group("entities").add_child(bullet)
	bullet.global_position = global_position
	return bullet
