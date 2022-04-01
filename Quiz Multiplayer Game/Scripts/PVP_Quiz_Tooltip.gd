extends Control

onready var tooltipLabel : Label = $VBoxContainer/ColorRect/TooltipLabel
onready var understoodButton : Button = $VBoxContainer/UnderstoodButton
onready var understoodTimer : Timer = $UnderstoodTimer
onready var timerLabel : Label = $VBoxContainer/TimerLabel

signal startGame

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_Update_Time()

func _Update_Time():
	var _start_Time_Left = int(understoodTimer.get_time_left())
	timerLabel.set_text(str("Starting in: ", _start_Time_Left))

func start_game():
	emit_signal("startGame")
	queue_free()

func _on_UnderstoodTimer_timeout():
	start_game()

func _on_UnderstoodButton_pressed():
	start_game()
