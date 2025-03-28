extends CanvasLayer

@export var level_name: String = "New Level"

@onready var level_label = $LevelLabel
@onready var bulb_counter = $BulbCounter


func _ready() -> void:
	level_label.text = level_name


func _process(delta: float) -> void:
	bulb_counter.text = "Bulbs: " + str(Inventory.bulbs)
