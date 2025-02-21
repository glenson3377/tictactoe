extends Node2D
var clock = true
var X = preload("res://X.png")
var O = preload("res://Alphabet-O-PNG-Background.png")
var sideeye = preload("res://side eye.jpg")
var scoop
var buttonvalue = [0,"1","2","3","4","5","6","7","8","9"]
var click = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(buttonvalue)
	$background.play()


func playerpress(button):
	var turn = get_node("CanvasGroup/CanvasLayer/GridContainer/TextureButton" + str(button))
	# true false cycler
	if clock == true:
		clock = false 
	else:
		clock = true
	#i clock is true give a pressed button a value then disable it
	if clock == true:
		turn.texture_disabled = X
		scoop = "X" 
		turn.disabled = true
	else:
		turn.texture_disabled = O
		turn.disabled = true
		scoop = "O"
	# update array 
	buttonvalue[button] = scoop
	print(buttonvalue)
	print("text for button " + str(button) + " has been pushed, locked with a " + str(scoop))
	
	#display who turn it is
	if clock == true:
		$CanvasGroup/CanvasLayer/Panel/Panel/player.text = "O"
	else:
		$CanvasGroup/CanvasLayer/Panel/Panel/player.text = "X"
	winner()
	if click == 8:
		tie()
	else:
		$reactions.play()
		click = click +1

func winner(): # check if somebody won yet
	print("checking for winner")
	if winnermetrix(buttonvalue, 1, 2, 3):
		print("test alr" + " Winner " + scoop)
		won()
	if winnermetrix(buttonvalue, 1, 5, 9):
		print("test alr" + " Winner " + scoop)
		won()
	if winnermetrix(buttonvalue, 4, 5, 6):
		print("test alr" + " Winner " + scoop)
		won()
	if winnermetrix(buttonvalue, 7, 8, 9):
		print("test alr" + " Winner " + scoop)
		won()
	if winnermetrix(buttonvalue, 7, 5, 3):
		print("test alr" + " Winner " + scoop)
		won()
	if winnermetrix(buttonvalue, 2, 5, 8):
		print("test alr" + " Winner " + scoop)
		won()
	if winnermetrix(buttonvalue, 1, 4, 7):
		print("test alr" + " Winner " + scoop)
		won()
	if winnermetrix(buttonvalue, 3, 6, 9):
		print("test alr" + " Winner " + scoop)
		won()
	if winnermetrix(buttonvalue, 7, 3, 5):
		print("test alr" + " Winner " + scoop)
		won()

#check that 3 indexes in the array are the same or not
func winnermetrix(array, po1, po2, po3):
	if array[po1] == array[po2] && array[po2] == array[po3]:
		return true
	else:
		return false
		
#winning banner
func won():
	$background.stop()
	#disable all buttons
	for i in range(9):
		get_tree().call_group("buttons", "set_disabled", true)
	print("hellyeah " + scoop + " really won this one lol")
	#display winner screen
	$"CanvasGroup/CanvasLayer/winner panel".visible = true
	if scoop == "X":
		$"CanvasGroup/CanvasLayer/winner panel/Label/TextureRect".texture = X
	else:
		$"CanvasGroup/CanvasLayer/winner panel/Label/TextureRect".texture = O
		
#if there is a tie do this
func tie():
	$AudioStreamPlayer.stop()
	#disable all buttons
	for i in range(9):
		get_tree().call_group("buttons", "set_disabled", true)
	print("hellyeah " + scoop + " really won this one lol")
	#display tie screen
	$"CanvasGroup/CanvasLayer/winner panel".visible = true
	$"CanvasGroup/CanvasLayer/winner panel/Label".text = "ooop its a tie"
	$"CanvasGroup/CanvasLayer/winner panel/Label/TextureRect".texture = sideeye



func _on_texture_button_1_pressed() -> void:
	playerpress(1)


func _on_texture_button_2_pressed() -> void:
	playerpress(2)


func _on_texture_button_3_pressed() -> void:
	playerpress(3)


func _on_texture_button_4_pressed() -> void:
	playerpress(4)


func _on_texture_button_5_pressed() -> void:
	playerpress(5)


func _on_texture_button_6_pressed() -> void:
	playerpress(6)


func _on_texture_button_7_pressed() -> void:
	playerpress(7)


func _on_texture_button_8_pressed() -> void:
	playerpress(8)


func _on_texture_button_9_pressed() -> void:
	playerpress(9)


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
