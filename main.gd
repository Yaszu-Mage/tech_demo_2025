extends Node2D
@onready var animator = $animator
var peer
@onready var menu_sound = $menu_sound
var can_go_back = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_end") and can_go_back:
		can_go_back = false
		if ($Multiplayer_Buttons.visible):
			$Multiplayer_Buttons.visible = false
			$Multiplayer_Buttons2.visible = true
		else:
			$Multiplayer_Buttons.visible = true
			$Multiplayer_Buttons2.visible = false
		Sounds.play_sound("res://menu.ogg",self)
		await get_tree().create_timer(0.1).timeout
		can_go_back = true


func _on_host_pressed() -> void:
	Lobby.create_game()
	Sounds.play_sound("res://selectsfx.ogg",self)
	$video.visible = true
	$video.play()
	await $video.finished
	$loading.visible = true

#This is the on join to set the address
func _on_join_pressed() -> void:
	$Multiplayer_Buttons.visible = false
	$Multiplayer_Buttons2.visible = true


func _on_real_join_pressed() -> void:
	Lobby.join_game($Multiplayer_Buttons2/Host.text)
