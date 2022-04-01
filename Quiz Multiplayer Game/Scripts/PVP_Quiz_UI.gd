extends Control

var points = 0

var button1Answer = false
var button2Answer = true

var selectedButton1 = null #Null so that you can't spam preguess and lose points cause nothing was picked
var selectedButton2 = null

var quizTimeAmount = 6

var wrongAnswer = false

onready var timeLeftLabel : Label = $VBoxContainer/TimeLeftLabel
onready var quizTimer : Timer = $VBoxContainer/QuizTimer
onready var pointsLabel : Label = $VBoxContainer/PointsLabel
onready var questionLabel : Label = $VBoxContainer/QuestionLabel
onready var answer1Button : Button = $VBoxContainer/CenterContainer1/HBoxContainer1/Button1
onready var answer2Button : Button = $VBoxContainer/CenterContainer1/HBoxContainer1/Button2

var currentQuiz = 0
var quizes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_quiz()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_Update_Time()

func _Update_Time():
	var _quiz_Time_Left = int(quizTimer.get_time_left())
	timeLeftLabel.set_text(str("Time Left: ", _quiz_Time_Left))

func _Update_Points():
	pointsLabel.set_text(str("Points: ", points))

func _Update_Question():
	if  currentQuiz < quizes.size():
		questionLabel.set_text(quizes[currentQuiz][0])
		answer1Button.set_text(quizes[currentQuiz][1])
		answer2Button.set_text(quizes[currentQuiz][2])

		button1Answer = quizes[currentQuiz][3]
		button2Answer = quizes[currentQuiz][4]

		selectedButton1 = null
		selectedButton2 = null

func _on_Button1_pressed():
	selectedButton1 = true
	selectedButton2 = false


func _on_Button2_pressed():
	selectedButton1 = false
	selectedButton2 = true


func _on_QuizTimer_timeout():
	
	check_right_answer(button1Answer, selectedButton1)
	check_right_answer(button2Answer, selectedButton2)
	
	check_wrong_answer(button1Answer, selectedButton1)
	check_wrong_answer(button2Answer, selectedButton2)

	_Update_Points()
	_Update_Question()

func populate_quiz():
	quizes.append(["Is a cookie a cat?", "No", "Hell Yes", true, false])
	quizes.append(["Did the thing do the thing?", "Maybe", "I aint seen notin", false, true])
	quizes.append(["This quiz is", "Amazing!", "Donkay", true, true])

func check_right_answer(answer, selectedAnswer):#TODO: make button text green for a moment
	if answer == true:
		if selectedAnswer == true:
			points = points + 25
		else:
			pass

func check_wrong_answer(answer, selectedAnswer): #TODO: make button text red for a moment
	if answer == true:
		if selectedAnswer == false:
			points = points - 25


func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/BattleRoyale/BattleRoyale_Quiz.tscn")
