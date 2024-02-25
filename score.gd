extends Label

func _process(delta):
	self.text = 'Fish Eaten: ' + str(Global.score) + '/' + str(Global.goal)
