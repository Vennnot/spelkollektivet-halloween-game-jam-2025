class_name BombEnemy
extends Enemy


func _ready() -> void:
	super._ready()
	pulse_effect(6, 12, 15, 7) 

func pulse_effect(total_time: float, cycles: int, scale_increase_percent: float, scale_increment_percent: float) -> void:
	if cycles <= 0:
		return
	
	var base_scale := sprite.scale
	var base_modulate := sprite.modulate  # Changed from modulate
	var target_color := Color.RED
	
	# Calculate time distribution for accelerating cycles
	var time_sum := 0.0
	for i in range(cycles):
		time_sum += pow(0.5, i)
	
	var first_cycle_duration := total_time / time_sum
	
	for cycle in range(cycles):
		var cycle_duration := first_cycle_duration * pow(0.5, cycle)
		var half_duration := cycle_duration / 2.0
		
		# Calculate scale for this cycle (increases by H% each time)
		var current_scale_increase := scale_increase_percent + (scale_increment_percent * cycle)
		var target_scale := base_scale * (1.0 + current_scale_increase / 100.0)
		
		# Scale up and turn red
		var tween_up := create_tween().set_parallel(true)
		tween_up.tween_property(visuals, "scale", target_scale, half_duration)
		tween_up.tween_property(visuals, "modulate", target_color, half_duration)
		await tween_up.finished
		
		# Scale down and return to base color
		var tween_down := create_tween().set_parallel(true)
		tween_down.tween_property(visuals, "scale", base_scale, half_duration)
		tween_down.tween_property(visuals, "modulate", base_modulate, half_duration)
		await tween_down.finished
	explode()

func explode():
	#explode!
	queue_free()
