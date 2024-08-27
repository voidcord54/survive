extends Sprite2D

@onready var hp = $hp
@onready var coin = $coin
@onready var player = %player

func _process(delta):
	self.show()
	hp.text = "= " + str(player.player_health)
	coin.text = "= " + str(global.coin)
