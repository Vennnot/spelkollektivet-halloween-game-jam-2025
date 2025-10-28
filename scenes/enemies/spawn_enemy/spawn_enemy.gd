class_name SpawnEnemy
extends Enemy

@onready var spawn_timer: Timer = %SpawnTimer
const CHASE_ENEMY = preload("uid://d0hl3bf6323tt")

func _ready() -> void:
	super._ready()
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)


func _on_spawn_timer_timeout():
	var original_position := position
	var shake_intensity := 8.0
	var duration := 1.0
	
	var tween = create_tween()
	tween.set_loops(5)  # Number of shake cycles
	
	for i in range(5):
		var target_pos = original_position + Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		tween.tween_property(self, "position", target_pos, duration / 20.0)
	
	# Return to original position
	await tween.finished
	position = original_position
		
	var chase_enemy := CHASE_ENEMY.instantiate()
	get_tree().get_first_node_in_group("entities").add_child(chase_enemy)
	chase_enemy.global_position = global_position
	spawn_timer.start()
