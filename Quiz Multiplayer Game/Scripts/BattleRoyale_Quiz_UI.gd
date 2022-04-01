extends Control

var points = 0

var button1Answer = false
var button2Answer = true
var button3Answer = false
var button4Answer = false

var selectedButton1 = null #Null so that you can't spam preguess and lose points cause nothing was picked
var selectedButton2 = null
var selectedButton3 = null
var selectedButton4 = null

var alive = true

var QuizesAnswered = 0

var quizTimeAmount = 6

var wrongAnswer = false

var playersLeftTeamBlue = 1
var playersLeftTeamRed = 3
var playerTeam = "Blue"

onready var timeLeftLabel : Label = $VBoxContainer/TimeLeftLabel
onready var quizTimer : Timer = $VBoxContainer/QuizTimer
onready var pointsLabel : Label = $VBoxContainer/PointsLabel
onready var questionLabel : Label = $VBoxContainer/QuestionLabel
onready var answer1Button : Button = $VBoxContainer/CenterContainer1/HBoxContainer1/Button1
onready var answer2Button : Button = $VBoxContainer/CenterContainer1/HBoxContainer1/Button2
onready var answer3Button : Button = $VBoxContainer/CenterContainer2/HBoxContainer1/Button3 #Hidden at start
onready var answer4Button : Button = $VBoxContainer/CenterContainer2/HBoxContainer1/Button4	#Hidden at start
onready var playersLeftLabel1 : Label = $VBoxContainer/PlayersLeftLabel1
onready var playersLeftLabel2 : Label = $VBoxContainer/PlayersLeftLabel2
onready var lostGameLabel : Label = $VBoxContainer/LostGameLabel

var currentQuiz = 0
var quizes = []

var quiz
var quiz_name = "Quiz BR"
var chosen_quiz = quiz_name

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

func SetBRQuiz(s_BR_quiz): # s_ = Server
	quiz = s_BR_quiz

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

		QuizesAnswered = QuizesAnswered + 1
	
	else:
		print("Quiz finished")

	if QuizesAnswered == 3:
		answer3Button.show()

	if QuizesAnswered == 6:
		answer4Button.show()

func _on_Button1_pressed():
	selectedButton1 = true
	selectedButton2 = false
	selectedButton3 = false
	selectedButton4 = false

func _on_Button2_pressed():
	selectedButton1 = false
	selectedButton2 = true
	selectedButton3 = false
	selectedButton4 = false

func _on_Button3_pressed():
	selectedButton1 = false
	selectedButton2 = false
	selectedButton3 = true
	selectedButton4 = false

func _on_Button4_pressed():
	selectedButton1 = false
	selectedButton2 = false
	selectedButton3 = false
	selectedButton4 = true

func _on_QuizTimer_timeout():
	
	check_right_answer(button1Answer, selectedButton1)
	check_right_answer(button2Answer, selectedButton2)
	
	check_wrong_answer(button1Answer, selectedButton1)
	check_wrong_answer(button2Answer, selectedButton2)

	_Update_Points()
	_Update_Question()
	
	currentQuiz = currentQuiz + 1

func update_players_left():
	playersLeftLabel1.set_text(str(playersLeftTeamBlue))
	playersLeftLabel2.set_text(str(playersLeftTeamRed))

func populate_quiz():
	Server.FetchBRQuiz(chosen_quiz, get_instance_id())

func check_right_answer(answer, selectedAnswer):#TODO: make button text green for a moment
	if alive == true:
		if answer == true:
			if selectedAnswer == true:
				points = points + 25
			else:
				pass

func check_wrong_answer(answer, selectedAnswer): #TODO: make button text red for a moment
	if alive == true:
		if answer == true:
			if selectedAnswer == false:
				alive = false #Player loses and is left to spectate
				if playerTeam == "Blue":
					playersLeftTeamBlue = playersLeftTeamBlue - 1
				if playerTeam == "Red":
					playersLeftTeamRed = playersLeftTeamRed - 1
				lostGameLabel.show()

func _on_TempButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn")


func _on_BattleRoyale_Tooltip_startGame():
	quizTimer.start()

