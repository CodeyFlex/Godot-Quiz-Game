extends Control

onready var startGameButton : Button = $VBoxContainer/StartGameButton
onready var hostGameButton : Button = $VBoxContainer/HostGameButton
onready var joinGameButton : Button = $VBoxContainer/JoinGameButton
onready var createQuizButton : Button = $VBoxContainer/CreateQuizButton
onready var downloadQuizButton : Button = $VBoxContainer/DownloadQuizButton
onready var quitGameButton : Button = $VBoxContainer/QuitGameButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartGameButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Social_Quiz/Social_Quiz.tscn")


func _on_HostGameButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/HostGame/HostGame.tscn")


func _on_JoinGameButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/JoinScene/JoinScene.tscn")


func _on_CreateQuizButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/CreateQuiz/CreateQuiz.tscn")


func _on_DownloadQuizButton_pressed():
	pass # Replace with function body.


func _on_QuitGameButton_pressed():
	get_tree().quit()
