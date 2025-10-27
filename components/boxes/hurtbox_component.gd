# Give the component a class name so it can be instanced as a custom node
class_name HurtboxComponent
extends Area2D

# Export the damage amount this hitbox deals
@export var damage = 1.0

# Create a signal for when the hitbox hits a hurtbox
signal hit_hitbox(hitbox: HitboxComponent)

func _ready():
	# Connect on area entered to our hurtbox entered function
	area_entered.connect(_on_hitbox_entered)

func _on_hitbox_entered(hitbox: HurtboxComponent):
	# Make sure the area we are overlapping is a hitbox
	if not hitbox is HurtboxComponent: return
	# Make sure the hitbox isn't invincible
	if hitbox.is_invincible: return
	# Signal out that we hit a hitbox (this is useful for destroying projectiles when they hit something)
	hit_hitbox.emit(hitbox)
	# Have the hitbox signal out that it was hit
	hitbox.hitted.emit(self)
