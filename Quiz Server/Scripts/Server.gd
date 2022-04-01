extends Node

var network = NetworkedMultiplayerENet.new()
var port = 1909
var max_players = 100

func _ready():
	StartServer()

func StartServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server started")
	
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")

func _Peer_Connected(player_id):
	print("User " + str(player_id) + " Connected")

func _Peer_Disconnected(player_id):
	print("user " + str(player_id) + " Disconnected")

#This function will be called by the client, in order to receive data from the server
remote func FetchQuiz(quiz_name, requester):
	var player_id = get_tree().get_rpc_sender_id()
	var quiz = get_node("Quiz").FetchQuiz(quiz_name)
	rpc_id(player_id, "ReturnQuiz", quiz, requester)
	print("sending " + str(quiz) + " to player")

remote func FetchBRQuiz(quiz_name, requester):
	var player_id = get_tree().get_rpc_sender_id()
	var quiz = get_node("Quiz").FetchBRQuiz(quiz_name)
	rpc_id(player_id, "ReturnBRQuiz", quiz, requester)
	print("sending " + str(quiz) + " to player")
