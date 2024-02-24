extends Node


var score = 0

func playSound(stream: AudioStreamPlayer):
	var instance = AudioStreamPlayer.new()
	instance.stream = stream 
	add_child(instance)
	instance.play()
