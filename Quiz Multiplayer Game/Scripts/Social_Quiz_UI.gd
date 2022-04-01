extends Control

var points = 0

var button1Answer = null
var button2Answer = null
var button3Answer = null
var button4Answer = null

var selectedButton1 = null #Null so that you can't spam preguess and lose points cause nothing was picked
var selectedButton2 = null
var selectedButton3 = null
var selectedButton4 = null

var wasAnswerChosenByNumber1 = false
var wasAnswerChosenByNumber2 = false
var wasAnswerChosenByNumber3 = false
var wasAnswerChosenByNumber4 = false

var answer1ChosenByNumber = 0
var answer2ChosenByNumber = 0
var answer3ChosenByNumber = 0
var answer4ChosenByNumber = 0

var gamestarted = false
var canBet = false

var quizTimeAmount = 12

var preGuessedAnswer = false
var wrongAnswer = false

onready var timeLeftLabel : Label = $VBoxContainer/TimeLeftLabel
onready var quizTimer : Timer = $VBoxContainer/QuizTimer
onready var betDelayTimer : Timer = $VBoxContainer/BetDelayTimer
onready var pointsLabel : Label = $VBoxContainer/PointsLabel
onready var questionLabel : Label = $VBoxContainer/QuestionLabel
onready var answer1Button : Button = $VBoxContainer/CenterContainer1/HBoxContainer1/Button1
onready var answer2Button : Button = $VBoxContainer/CenterContainer1/HBoxContainer1/Button2
onready var answer3Button : Button = $VBoxContainer/CenterContainer2/HBoxContainer2/Button3
onready var answer4Button : Button = $VBoxContainer/CenterContainer2/HBoxContainer2/Button4
onready var chosenByNumberLabel1 : Label = $VBoxContainer/CenterContainer1/HBoxContainer1/Button1/ChosenByNumberLabel1
onready var chosenByNumberLabel2 : Label = $VBoxContainer/CenterContainer1/HBoxContainer1/Button2/ChosenByNumberLabel2
onready var chosenByNumberLabel3 : Label = $VBoxContainer/CenterContainer2/HBoxContainer2/Button3/ChosenByNumberLabel3
onready var chosenByNumberLabel4 : Label = $VBoxContainer/CenterContainer2/HBoxContainer2/Button4/ChosenByNumberLabel4
onready var chosenByNumberLabel5 : Label = $VBoxContainer/BetAnswerButton/ChosenByNumberLabel5
onready var betAnswerTimerLabel : Label = $VBoxContainer/BetAnswerButton/BetAnswerTimerLabel

var currentQuiz = 0
var quizes = []

signal answer_Signal1
signal answer_Signal2
signal answer_Signal3
signal answer_Signal4
signal answer_Reset_Signal

var quiz
var quiz_name = "Quiz Disney"
var chosen_quiz = quiz_name #Temporary value

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_quiz()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_Update_Time()
	display_answer_chosen_labels() #Maybe shouldn't be called constanly when attached to server
	update_answer_chosen()
	update_bet_answer_label()

func _Update_Time():
	var _quiz_Time_Left = int(quizTimer.get_time_left())
	timeLeftLabel.set_text(str("Time Left: ", _quiz_Time_Left))

func _Update_Points():
	pointsLabel.set_text(str("Points: ", points))

func SetQuiz(s_quiz): # s_ = Server
	quiz = s_quiz

func _Update_Question():
	if  currentQuiz < quiz[quiz_name].size():
		var round_number = "Round_" + str(currentQuiz)
		questionLabel.set_text(str(quiz[quiz_name][round_number].Quiz_Question))
		answer1Button.set_text(str(quiz[quiz_name][round_number].Answer1))
		answer2Button.set_text(str(quiz[quiz_name][round_number].Answer2))
		answer3Button.set_text(str(quiz[quiz_name][round_number].Answer3))
		answer4Button.set_text(str(quiz[quiz_name][round_number].Answer4))

		button1Answer = quiz[quiz_name][round_number].AnswerBoolean1
		button2Answer = quiz[quiz_name][round_number].AnswerBoolean2
		button3Answer = quiz[quiz_name][round_number].AnswerBoolean3
		button4Answer = quiz[quiz_name][round_number].AnswerBoolean4

		selectedButton1 = null
		selectedButton2 = null
		selectedButton3 = null
		selectedButton4 = null
	
	else:
		print("Quiz finished")

func _on_Button1_pressed():
	selectedButton1 = true
	selectedButton2 = false
	selectedButton3 = false
	selectedButton4 = false
	show_answer_chosen()
	emit_signal("answer_Signal1")


func _on_Button2_pressed():
	selectedButton1 = false
	selectedButton2 = true
	selectedButton3 = false
	selectedButton4 = false
	show_answer_chosen()
	emit_signal("answer_Signal2")


func _on_Button3_pressed():
	selectedButton1 = false
	selectedButton2 = false
	selectedButton3 = true
	selectedButton4 = false
	show_answer_chosen()
	emit_signal("answer_Signal3")


func _on_Button4_pressed():
	selectedButton1 = false
	selectedButton2 = false
	selectedButton3 = false
	selectedButton4 = true
	show_answer_chosen()
	emit_signal("answer_Signal4")

func show_answer_chosen(): #This function should really be cleaned if possible
	if gamestarted == true:
		if selectedButton1 == true && wasAnswerChosenByNumber1 == false:
			answer1ChosenByNumber = answer1ChosenByNumber + 1
			wasAnswerChosenByNumber1 = true
			
			if wasAnswerChosenByNumber2 == true:
				answer2ChosenByNumber = answer2ChosenByNumber - 1
			if wasAnswerChosenByNumber3 == true:
				answer3ChosenByNumber = answer3ChosenByNumber - 1
			if wasAnswerChosenByNumber4 == true:
				answer4ChosenByNumber = answer4ChosenByNumber - 1
			
			wasAnswerChosenByNumber2 = false
			wasAnswerChosenByNumber3 = false
			wasAnswerChosenByNumber4 = false

		if selectedButton2 == true && wasAnswerChosenByNumber2 == false:
			answer2ChosenByNumber = answer2ChosenByNumber + 1
			wasAnswerChosenByNumber2 = true
			
			if wasAnswerChosenByNumber1 == true:
				answer1ChosenByNumber = answer1ChosenByNumber - 1
			if wasAnswerChosenByNumber3 == true:
				answer3ChosenByNumber = answer3ChosenByNumber - 1
			if wasAnswerChosenByNumber4 == true:
				answer4ChosenByNumber = answer4ChosenByNumber - 1
			
			wasAnswerChosenByNumber1 = false
			wasAnswerChosenByNumber3 = false
			wasAnswerChosenByNumber4 = false

		if selectedButton3 == true && wasAnswerChosenByNumber3 == false:
			answer3ChosenByNumber = answer3ChosenByNumber + 1
			wasAnswerChosenByNumber3 = true
			
			if wasAnswerChosenByNumber2 == true:
				answer2ChosenByNumber = answer2ChosenByNumber - 1
			if wasAnswerChosenByNumber1 == true:
				answer1ChosenByNumber = answer1ChosenByNumber - 1
			if wasAnswerChosenByNumber4 == true:
				answer4ChosenByNumber = answer4ChosenByNumber - 1
			
			wasAnswerChosenByNumber2 = false
			wasAnswerChosenByNumber1 = false
			wasAnswerChosenByNumber4 = false

		if selectedButton4 == true && wasAnswerChosenByNumber4 == false:
			answer4ChosenByNumber = answer4ChosenByNumber + 1
			wasAnswerChosenByNumber4 = true
			
			if wasAnswerChosenByNumber2 == true:
				answer2ChosenByNumber = answer2ChosenByNumber - 1
			if wasAnswerChosenByNumber3 == true:
				answer3ChosenByNumber = answer3ChosenByNumber - 1
			if wasAnswerChosenByNumber1 == true:
				answer1ChosenByNumber = answer1ChosenByNumber - 1
			
			wasAnswerChosenByNumber2 = false
			wasAnswerChosenByNumber3 = false
			wasAnswerChosenByNumber1 = false

func display_answer_chosen_labels():
	if answer1ChosenByNumber >= 1:
		chosenByNumberLabel1.show()
	else:
		chosenByNumberLabel1.hide()

	if answer2ChosenByNumber >= 1:
		chosenByNumberLabel2.show()
	else:
		chosenByNumberLabel2.hide()

	if answer3ChosenByNumber >= 1:
		chosenByNumberLabel3.show()
	else:
		chosenByNumberLabel3.hide()

	if answer4ChosenByNumber >= 1:
		chosenByNumberLabel4.show()
	else:
		chosenByNumberLabel4.hide()

func update_answer_chosen():
	chosenByNumberLabel1.set_text(str(answer1ChosenByNumber))
	chosenByNumberLabel2.set_text(str(answer2ChosenByNumber))
	chosenByNumberLabel3.set_text(str(answer3ChosenByNumber))
	chosenByNumberLabel4.set_text(str(answer4ChosenByNumber))

func reset_answer_chosen():
	answer1ChosenByNumber = 0
	answer2ChosenByNumber = 0
	answer3ChosenByNumber = 0
	answer4ChosenByNumber = 0

func _on_QuizTimer_timeout():
	gamestarted = true
	
	check_answer(button1Answer, selectedButton1)
	check_answer(button2Answer, selectedButton2)
	check_answer(button3Answer, selectedButton3)
	check_answer(button4Answer, selectedButton4)

	_Update_Points()
	_Update_Question()
	emit_signal("answer_Reset_Signal")
	reset_answer_chosen()
	currentQuiz = currentQuiz + 1

	preGuessedAnswer = false #Reset for new question
	
	quizTimer.start(quizTimeAmount)
	
	canBet = false
	betDelayTimer.start(5)

func populate_quiz():
	Server.FetchQuiz(chosen_quiz, get_instance_id())

func check_answer(answer, selectedAnswer):
	if answer == true:
		if selectedAnswer == true:
			points = points + 25
		elif selectedAnswer == false:
			if preGuessedAnswer == true:
				points = points - 25

func update_bet_answer_label():
	var _bet_Time_Left = int(betDelayTimer.get_time_left())
	betAnswerTimerLabel.set_text(str(_bet_Time_Left))

	if _bet_Time_Left == 0:
		betAnswerTimerLabel.hide()
	else:
		betAnswerTimerLabel.show()

func _on_BetAnswerButton_pressed():
	if selectedButton1 != null: #Checks if a button has been pressed at all
		if gamestarted == true:
			if canBet == true:
				preGuessedAnswer = true
				quizTimer.emit_signal("timeout")
				quizTimer.start(quizTimeAmount)

func _on_TempContinueButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/PVP_Quiz/PVP_Quiz.tscn")


func _on_BetDelayTimer_timeout():
	canBet = true
