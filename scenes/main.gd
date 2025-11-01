class_name Main
extends Node
@onready var entities: Node = %Entities
@onready var main_ui: MainUI = %MainUI

var active_room : Node

var items : Array[ItemResource]
var items_to_spawn : Array[ItemResource]


func _ready() -> void:
	Events.room_changed.connect(_on_room_changed)
	items_to_spawn.append(load("uid://c83c7e3skiqsf"))
	items_to_spawn.append(load("uid://mo6flgtqndlr"))
	items_to_spawn.append(load("uid://bosd66huejyd7"))
	items_to_spawn.append(load("uid://cw0n2xvx7konc"))
	items_to_spawn.append(load("uid://csu6ww5nte5m0"))
	items_to_spawn.append(load("uid://c8l7wdlkgwrww"))
	items_to_spawn.shuffle()
	
	var item_to_spawn :ItemResource= items_to_spawn.pop_front()
	var item_scene :Item= load("uid://dekltjjwowiir").instantiate()
	get_tree().get_first_node_in_group("entities").add_child(item_scene)
	item_scene.resource = item_to_spawn
	item_scene.update_visuals()
	item_scene.global_position = Vector2(-430,-130)
	
	item_to_spawn= items_to_spawn.pop_front()
	var _1 :Item= load("uid://dekltjjwowiir").instantiate()
	get_tree().get_first_node_in_group("entities").add_child(_1)
	_1.resource = item_to_spawn
	_1.update_visuals()
	_1.global_position = Vector2(430,-130)
	
	AudioManager.play("music","music")
	#item_to_spawn= items_to_spawn.pop_front()
	#var _2 :Item= load("uid://dekltjjwowiir").instantiate()
	#get_tree().get_first_node_in_group("entities").add_child(_2)
	#_2.resource = item_to_spawn
	#_2.update_visuals()
	#_2.global_position = Vector2(0,240)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		EnemySpawner.reset_variables()
		SceneChanger.go_to_main()


func _on_room_changed(room:Room):
	for i in entities.get_children():
		if i is Item:
			get_tree().paused = true
			items.append(i.resource)
			i.take_away()
			await i.taken_away
			main_ui.boss_objects.fill_next_item_slot(i.resource.sprite)
			i.despawn()
	get_tree().paused = false
	room.call_deferred("start")
