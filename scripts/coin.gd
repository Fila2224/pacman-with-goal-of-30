extends Area2D

var status = "coin"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale.x = 50
	scale.y = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	





@onready var pacmanborder: Area2D = $pacmanborder








func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().status == "pacman" :
		area.get_parent().score +=1
		queue_free()
