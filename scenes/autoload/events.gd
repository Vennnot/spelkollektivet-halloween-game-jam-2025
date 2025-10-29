extends Node

signal player_health_changed(new_value: int)
signal player_health_added(texture:Texture)

signal item_changed(slot:int,texture:Texture)

signal room_changed(active_room:Room	)

signal game_over
