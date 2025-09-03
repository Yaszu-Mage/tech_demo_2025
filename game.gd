extends Node2D
@onready var sorcerer_pre = preload("res://player.tscn")
@onready var slime_pre = preload("res://slime.tscn")
var ran = false
func start_game():
	print("started game!")
	rpc("init")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lobby.player_loaded.rpc_id(1)
	set_multiplayer_authority(Lobby.multiplayer.get_unique_id())
	init()


	
	
@rpc("any_peer","call_remote")
func init():
	print("init")
	if (is_multiplayer_authority()):
		var id = get_multiplayer_authority()
		if (Lobby.player_info.get("team")):
			var sorcerer = sorcerer_pre.instantiate()
			sorcerer.name = str(id)
			sorcerer.set_multiplayer_authority(id)
			$Sorcerers.add_child(sorcerer)
		else:
			var slime = slime_pre.instantiate()
			slime.name = str(id)
			slime.set_multiplayer_authority(id)
			$Slimes.add_child(slime)
		print("creating player")
		rpc("create_player",id,Lobby.player_info.get("team"))
	rpc("sync_online")


@rpc("any_peer","call_remote")
func create_player(id : int, team : bool):
	print("creating player")
	if (team):
		var sorcerer = sorcerer_pre.instantiate()
		sorcerer.name = str(id)
		sorcerer.set_multiplayer_authority(id)
		$Sorcerers.add_child(sorcerer)
	else:
		var slime = slime_pre.instantiate()
		slime.name = str(id)
		slime.set_multiplayer_authority(id)
		$Slimes.add_child(slime)
		print("creating player")


@rpc("any_peer","call_remote")
func sync_online():
	rpc("sync_me",get_multiplayer_authority(),Lobby.player_info.get("team"))

@rpc("any_peer")
func sync_me(id:int, team :bool):
	print("syncing ", id)
	if (team):
		if (get_node_or_null("Sorcerers/" + str(id)) == null):
			var sorcerer = sorcerer_pre.instantiate()
			sorcerer.name = str(id)
			sorcerer.set_multiplayer_authority(id)
			$Sorcerers.add_child(sorcerer)
	else:
		if (get_node_or_null("Slimes/" + str(id)) == null):
			var slime = slime_pre.instantiate()
			slime.name = str(id)
			slime.set_multiplayer_authority(id)
			$Slimes.add_child(slime)
			print("creating player")
