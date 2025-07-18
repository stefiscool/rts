extends CanvasLayer

func _process(delta: float) -> void:
	if Global.mana == Global.maxMana:
		$ManaLabel.text = "MANA FULL!"
	else:
		$ManaLabel.text = str(Global.mana) + " Mana"
	$ColorRect6.scale.x = float(Global.mana)/float(Global.maxMana)
	
