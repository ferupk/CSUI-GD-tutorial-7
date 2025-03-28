extends Interactable

@export var off_at_start: bool = false

@onready var head_on = $CSG/HeadOn
@onready var head_off = $CSG/HeadOff

var on: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on = true if !off_at_start else false
	_toggle_light()


func _toggle_light():
	head_on.visible = true if on else false
	head_off.visible = false if on else true


func interact():
	if Inventory.bulbs > 0 and !on:
		on = true
		_toggle_light()
		Inventory.bulbs -= 1
