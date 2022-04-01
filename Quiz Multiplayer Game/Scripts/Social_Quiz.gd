extends Node2D

onready var gameTimer : Timer = $GameTimer
onready var gameTimerLabel : Label = $GameTimerLabel
onready var player : KinematicBody2D = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_Update_Time()


func _Update_Time():
	var _game_Time_Left = int(gameTimer.get_time_left())
	gameTimerLabel.set_text(str("Game Time Left: ", _game_Time_Left))

func _on_GameTimer_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/PVP_Quiz/PVP_Quiz.tscn")


func _on_Quiz_UI_answer_Signal1():
	player.position = Vector2(-388, -198)


func _on_Quiz_UI_answer_Signal2():
	player.position = Vector2(331, -231)


func _on_Quiz_UI_answer_Signal3():
	player.position = Vector2(-332, 216)


func _on_Quiz_UI_answer_Signal4():
	player.position = Vector2(384, 183)


func _on_Quiz_UI_answer_Reset_Signal():
	player.position = Vector2(-40, -963)
