class_name EnemyAbilityComponent
extends Node

signal ability_ready
signal ability_started
signal ability_finished

@onready var ability_cooldown_timer: Timer = %AbilityCooldownTimer
@onready var ability_duration_timer: Timer = %AbilityDurationTimer

@export var base_ability_cooldown : float = 15
var ability_cooldown : float = 0

@export var base_ability_duration : float = 3
var ability_duration : float = 0

var changes_sprite := false

func _ready():
	ability_cooldown_timer.wait_time = base_ability_cooldown+randf_range(base_ability_cooldown*0.1,base_ability_cooldown*0.1)
	ability_duration_timer.wait_time = base_ability_duration+randf_range(base_ability_duration*0.1,base_ability_duration*0.1)
	ability_cooldown_timer.start()
	ability_cooldown_timer.timeout.connect(_on_ability_cooldown_timer_timeout)
	ability_duration_timer.timeout.connect(_on_ability_duration_timer_timeout)


func start_ability():
	ability_finished.emit()


func _on_ability_cooldown_timer_timeout():
	ability_ready.emit()


func _on_ability_duration_timer_timeout():
	ability_finished.emit()
