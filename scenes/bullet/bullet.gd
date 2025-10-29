class_name Bullet extends CharacterBody2D

const PUDDLE = preload("uid://b8qvs03ix3tmq")

var launched := true

var player :Player
var max_bounces := 3
var current_bounces := 0
var nutella := false
var pomegranate := false
var boomerang_acceleration :float= 0
var initial_speed : float

@onready var sprite: Sprite2D = $Visuals/Sprite

@onready var hurtbox: HurtboxComponent = %HurtboxComponent

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if not player:
		return
	
	check_items()

func check_items():
	for item in player.items:
		if not item:
			continue
		elif item.id == "bubblegum":
			max_bounces = 5
		elif item.id == "nutella":
			nutella = true
		elif item.id == "pomegranate":
			pomegranate = true
		elif item.id == "croissant":
			boomerang_acceleration = 0.8
		


func throw(direction: Vector2, move_speed: float, damage: int):
	initial_speed = move_speed
	velocity = direction * move_speed
	hurtbox.damage = damage
	launched = true 


func _physics_process(delta: float) -> void:
	if not launched:
		return
	if player:
		apply_boomerang_physics(delta)
	
	move_and_slide()
	var collision = get_last_slide_collision()
	if collision != null:
		handle_bounce(collision)


func apply_boomerang_physics(delta: float):
	if not is_instance_valid(player):
		return
	
	var direction_to_player = (player.global_position - global_position).normalized()
	var target_speed = 1200.0  # Set a consistent boomerang speed
	var desired_velocity = direction_to_player * target_speed
	
	# Lerp to change direction while maintaining/building speed
	velocity = velocity.lerp(desired_velocity, boomerang_acceleration * delta)


func handle_bounce(collision: KinematicCollision2D):
	# Check if we have bounces remaining
	if current_bounces >= max_bounces:
		destroy()
		return
	
	# Get the collision normal
	var normal = collision.get_normal()
	
	# Calculate perfect reflection angle
	var perfect_reflection = velocity.bounce(normal)
	
	# Add random angle variation (+-15 degrees)
	var random_angle = deg_to_rad(randf_range(-15.0, 15.0))
	var varied_direction = perfect_reflection.rotated(random_angle)
	
	# Update velocity with the new direction (maintain speed)
	var current_speed = velocity.length()
	velocity = varied_direction.normalized() * current_speed
	
	# Increment bounce counter
	current_bounces += 1


func destroy():
	call_deferred("spawn_puddle")
	queue_free()


func spawn_puddle():
	if not nutella:
		return
	
	var nutella_scene :Puddle= PUDDLE.instantiate()
	get_tree().get_first_node_in_group("entities").add_child(nutella_scene)
	nutella_scene.global_position = global_position

func _on_hurtbox_component_hit_hitbox(hitbox: HitboxComponent) -> void:
	var parent := hitbox.get_parent()
	if parent is Enemy:
		if pomegranate:
			if parent.bullet_sprite == null:
				var bullet_sprite := Sprite2D.new()
				parent.bullet_sprite = bullet_sprite
				parent.visuals.add_child(bullet_sprite)
				bullet_sprite.scale = Vector2.ZERO
				bullet_sprite.texture = sprite.texture
				parent.bullet_explosion()
		else:
			parent.health_component.damage(1)
	destroy()
