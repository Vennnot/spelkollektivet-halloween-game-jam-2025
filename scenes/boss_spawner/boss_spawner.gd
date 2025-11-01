extends Area2D

const BOSS_ENEMY = preload("uid://beqnfnjxu5dhb")

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(other_area:Area2D):
	if other_area.get_parent() is Player:
		AudioManager.play("boss","music")
		var boss_scene := BOSS_ENEMY.instantiate()
		get_tree().get_first_node_in_group("entities").call_deferred("add_child", boss_scene)
		boss_scene.global_position = global_position
		call_deferred("queue_free")
