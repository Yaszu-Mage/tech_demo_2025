extends Node2D
@onready var animator = $animator
var peer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_host_pressed() -> void:
	pass # Replace with function body.


#This is the on join to set the address
func _on_join_pressed() -> void:
	pass # Replace with function body.
