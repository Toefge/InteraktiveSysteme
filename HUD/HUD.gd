extends CanvasLayer

var killsPlayer1 = 0
var killsPlayer2 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_player1_killed():
	killsPlayer2 += 1
	$KillsPlayer2.text = "Kills  "+ str(killsPlayer2)
	if(killsPlayer2 == 3):
		winner("Player 2")

func _on_player2_killed():
	killsPlayer1 += 1
	$KillsPlayer1.text = "Kills  "+ str(killsPlayer1)
	if(killsPlayer1 == 3):
		winner("Player 1")

func winner(playerName):
	playSound()
	$WinnerLabel.show()
	$WinnerLabel.text = playerName + " Wins"
	yield(get_tree().create_timer(5), "timeout")
	get_tree().change_scene("res://Menu/Menu.tscn")
	
func playSound():
	match (randi() % 6 +1):
		1:
			$Win1.play()
		2:
			$Win2.play()
		3:
			$Win3.play()
		4:
			$Win4.play()
		5:
			$Win5.play()
		6:
			$Win6.play()
