extends Node

var network = NetworkedMultiplayerENet.new()
var ip = "127.0.0.1"
var port = 1909

func _ready():
	ConnectToServer()

func ConnectToServer():
	network.create_client(ip, port)
	get_tree().set_network_peer(network) #Push an ID to server
	
	network.connect("connection_failed", self, "_OnConnectionFailed")
	network.connect("connection_succeeded", self, "_OnConnectionSucceeded")

func _OnConnectionFailed():
	print("Failed to connect")

func _OnConnectionSucceeded():
	print("Succesfully connected")

#Quiz Server
func FetchQuiz(quiz_name, requester):
	rpc_id(1, "FetchQuiz", quiz_name, requester)

remote func ReturnQuiz(s_quiz, requester):
	instance_from_id(requester).SetQuiz(s_quiz)

#BR Quiz
func FetchBRQuiz(quiz_name, requester):
	rpc_id(1, "FetchBRQuiz", quiz_name, requester)

remote func ReturnBRQuiz(s_BR_quiz, requester):
	instance_from_id(requester).SetBRQuiz(s_BR_quiz)
