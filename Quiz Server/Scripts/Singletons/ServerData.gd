extends Node

var quiz_disney
var quiz_BR

func _ready():
#Social Quiz
	var quiz_disney_file = File.new()
	quiz_disney_file.open("res://Data/Quiz_Disney.JSON", File.READ)
	var quiz_disney_json = JSON.parse(quiz_disney_file.get_as_text())
	quiz_disney_file.close()
	quiz_disney = quiz_disney_json.result

#BR Quiz
	var quiz_BR_file = File.new()
	quiz_BR_file.open("res://Data/BR_Quiz.JSON", File.READ)
	var quiz_BR_json = JSON.parse(quiz_BR_file.get_as_text())
	quiz_BR_file.close()
	quiz_BR = quiz_BR_json.result
