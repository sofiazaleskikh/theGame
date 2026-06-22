extends Node2D

# Hier speichern wir, wie viele Erdbeeren es insgesamt gibt
var total_strawberries : int = 0
var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Goal/CanvasLayer/Label.visible = false
	# Automatisch zählen, wie viele Erdbeeren im Ordner liegen
	total_strawberries = $Strawberries.get_child_count()
	print("Erdbeeren im Level: ", total_strawberries)
	
	# Das "collected"-Signal von JEDER Erdbeere verbinden
	for strawberry in $Strawberries.get_children():
		strawberry.collected.connect(_on_strawberry_collected)

# Wird aufgerufen, JEDES MAL wenn eine Erdbeere eingesammelt wird
func _on_strawberry_collected() -> void:
	# Erdbeeren-Zähler verringern
	total_strawberries -= 1
	
	# Punkte erhöhen (100 Punkte pro Erdbeere)
	score += 100
	update_score_display()
	
	print("Verbleibende Erdbeeren: ", total_strawberries)
	
	# Wenn alle Erdbeeren weg sind, kommt das visuelle Feedback
	if total_strawberries <= 0:
		show_level_complete()

# Aktualisiert die Punkteanzeige auf deinem UI
func update_score_display() -> void:
	# Wir prüfen, ob das übergeordnete Skript (main.gd) unsere Funktion hat
	if get_parent() and get_parent().has_method("increase_score"):
		# Wir rufen deine originale Funktion aus der main auf!
		get_parent().increase_score()
	

func show_level_complete() -> void:
	# Feedback: Siegestext anzeigen (Pfad aus Grafik 2)
	$Goal/CanvasLayer/Label.visible = true
	# Feedback: Spiel verlangsamen für den "Sieg-Moment"
	Engine.time_scale = 0.5
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_goal_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Level Completed! Level-Sieg!")
		$Goal/CanvasLayer/Label.visible = true
		Engine.time_scale = 0.5 # Feedback
