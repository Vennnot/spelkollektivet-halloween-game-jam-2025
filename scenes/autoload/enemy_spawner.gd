extends Node

var watermelon := false
var chestnut := false
var nutella := false
var bubblegum := false
var pomegranate := false
var croissant := false

const BOMB_ENEMY = preload("uid://cmc3p7oryp51n")
const CHASE_ENEMY = preload("uid://d0hl3bf6323tt")
const SHOOT_ENEMY = preload("uid://cd1vjws6681ft")
const SPAWN_ENEMY = preload("uid://dy4l1vdcborhi")
const BOUNCE_ENEMY = preload("uid://bso4msvkhru8m")
const PUDDLE_ENEMY = preload("uid://7wsyayhj1tqm")


func reset_variables():
	watermelon = false
	chestnut = false
	nutella = false
	bubblegum = false
	pomegranate = false
	croissant = false


func update_variables(item:ItemResource):
	match item.id:
		"watermelon":
			watermelon = true
		"chestnut":
			chestnut = true
		"nutella":
			nutella = true
		"bubblegum":
			bubblegum = true
		"pomegranate":
			pomegranate = true
		"croissant":
			croissant = true


func fetch_random_enemy()->PackedScene:
	var possible_enemies :=[]
	if watermelon:
		possible_enemies.append(SHOOT_ENEMY)
	elif chestnut:
		possible_enemies.append(SPAWN_ENEMY)
	elif nutella:
		possible_enemies.append(PUDDLE_ENEMY)
	elif bubblegum:
		possible_enemies.append(BOUNCE_ENEMY)
	elif pomegranate:
		possible_enemies.append(BOMB_ENEMY)
	elif croissant:
		possible_enemies.append(CHASE_ENEMY)
	return possible_enemies.pick_random()
