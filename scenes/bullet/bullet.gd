class_name Bullet extends CharacterBody2D

var launched := true

var player :Player
var number_of_bounces := 0

@onready var hurtbox: HurtboxComponent = %HurtboxComponent

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if player:
		pass


func throw(direction: Vector2, move_speed: float, damage: int):
	velocity = direction * move_speed
	hurtbox.damage = damage
	launched = true 

func _physics_process(delta: float) -> void:
	if launched:
		move_and_slide()
		
		if get_last_slide_collision() != null:
			destroy()

func destroy():
	queue_free()

func _on_hurtbox_component_hit_hitbox(hitbox: HitboxComponent) -> void:
	destroy()
