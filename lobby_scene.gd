extends Control
var selected = false
var can_ready = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$VBoxContainer/TextEdit2.text = "Players: " + str(Lobby.players.size())
	$VBoxContainer/TextEdit.text = "Address: " + str(get_local_ipv4_address())
	Lobby.player_info.set("name", $VBoxContainer/TextEdit3.text)
	if ($VBoxContainer/TextEdit3.text.to_lower().contains("name") || $VBoxContainer/TextEdit3.text.length() < 5):
		$VBoxContainer/AnimatedSprite2D.play("default")
		$VBoxContainer/AnimatedSprite2D.visible = true
		$VBoxContainer/AnimatedSprite2D/RichTextLabel.text = "Set me!"
		$VBoxContainer/AnimatedSprite2D.self_modulate = Color(1,1,1,1)
		$VBoxContainer/AnimatedSprite2D/RichTextLabel.self_modulate = Color(1,1,1,1)
		can_ready = false
	else:
		$VBoxContainer/AnimatedSprite2D.visible = false
		$VBoxContainer/AnimatedSprite2D.stop()
		if $VBoxContainer/TextEdit3.text.to_lower().contains("skibidi") || $VBoxContainer/TextEdit3.text.to_lower().contains("sigma") || $VBoxContainer/TextEdit3.text.to_lower().contains("67") || $VBoxContainer/TextEdit3.text.to_lower().contains("phonk")|| $VBoxContainer/TextEdit3.text.to_lower().contains("nigg@") || $VBoxContainer/TextEdit3.text.to_lower().contains("nigga")|| $VBoxContainer/TextEdit3.text.to_lower().contains("n1gg3r") || $VBoxContainer/TextEdit3.text.to_lower().contains("nigger")|| $VBoxContainer/TextEdit3.text.to_lower().contains("s1gma"):
			$VBoxContainer/AnimatedSprite2D.play("default")
			$VBoxContainer/AnimatedSprite2D.visible = true
			$VBoxContainer/AnimatedSprite2D.self_modulate = Color(1,0,0,1)
			$VBoxContainer/AnimatedSprite2D/RichTextLabel.self_modulate = Color(1,0,0,1)
			$VBoxContainer/AnimatedSprite2D/RichTextLabel.text = "Change it."
			can_ready = false
		else:
			can_ready = true
	if can_ready:
		$PanelContainer/HBoxContainer/VBoxContainer/Button.disabled = false
	else:
		$PanelContainer/HBoxContainer/VBoxContainer/Button.disabled = true


func _on_movement_pressed() -> void:
	selected = not selected
	$PanelContainer/HBoxContainer/VBoxContainer/sorcerer.visible = selected
	$PanelContainer/HBoxContainer/VBoxContainer/slime.visible = not selected
	print(selected)
func get_local_ipv4_address() -> String:
	var local_ip = ""
	for address in IP.get_local_addresses():
		# Filter for IPv4 addresses that are not loopback (127.x.x.x) or APIPA (169.254.x.x)
		if "." in address and not address.begins_with("127.") and not address.begins_with("169.254."):
			# Check for common private IP ranges (192.168.x.x, 10.x.x.x, 172.16-31.x.x)
			if address.begins_with("192.168.") or address.begins_with("10."):
				local_ip = address
				break
			elif address.begins_with("172."):
				var segments = address.split(".")
				if segments.size() >= 2:
					var second_segment = int(segments[1])
					if second_segment >= 16 and second_segment <= 31:
						local_ip = address
						break
	return local_ip


func _on_button_pressed() -> void:
	Lobby.player_info.set("team", selected)
	Lobby.load_game("res://game.tscn")
	
