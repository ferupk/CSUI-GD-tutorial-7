extends Interactable


func interact():
	Inventory.bulbs += 1
	self.queue_free()
