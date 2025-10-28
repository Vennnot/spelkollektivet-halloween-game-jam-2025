class_name HealthComponent
extends Node

signal died
signal damaged
signal healed


@export var health : int = 1 : set = _set_health

var health_depleted : bool = false
var disabled := false


func _set_health(value:int):
	if health_depleted:
		return
	
	health = value
	if health <= 0:
		health_depleted = true
		died.emit()


func heal(value:int):
	if health_depleted or disabled:
		return
	
	health += value
	healed.emit()


func damage(value:int):
	if health_depleted or disabled:
		return
	
	self.health -= value
	damaged.emit()


func kill():
	self.health = 0
