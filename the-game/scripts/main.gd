extends Node2D
@onready var label: Label = $HUD/ScorePanel/Label
var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _setup_level() -> void:
	var strawberries = $Level.get_node_or_null("Strawberries")
	if strawberries:
		for strawberry in strawberries.get_children():
			strawberry.collected.connect(increase_score)

func increase_score(amount: int = 100) -> void:
	score += amount
	# Wir prüfen kurz, ob das Label wirklich existiert, bevor wir hineinschreiben
	if label:
		label.text = "SCORE: %s" % score
	
