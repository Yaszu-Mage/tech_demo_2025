extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_sound(path: String, node : Node):
	var player : AudioStreamPlayer = AudioStreamPlayer.new()
	node.add_child(player)
	player.stream = load(path)
	player.play()
	await player.finished
	player.queue_free()
