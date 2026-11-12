extends Node2D
var status = "ghoast"
var direction = 1
var SPEED = 1000
var stav = "chill"
var reset = false
var pacman
var skibidi = 1
@onready var raycastdown : RayCast2D = $raycastdown
@onready var raycastup : RayCast2D = $raycastright
@onready var raycastleft : RayCast2D = $raycastleft
@onready var raycastright : RayCast2D = $raycastup
@onready var skin : Sprite2D = $Sprite2D
func _ready() -> void:
	scale.x = 25
	scale.y = 25
	skin.texture = load("res://.godot/imported/blinky.png-1e3ce8b2de40d1eaba8a997d57b72047.ctex")
	pacman = get_tree().get_first_node_in_group("pacman")
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_method("dealdamage"):
		SPEED *= -10
		reset = true
	if area.has_method("smrdim") and pacman.boost == "yes":
		print("rip")
		queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	SPEED *=-10
	reset = true
func _process(delta: float) -> void: #1 = doprava 2= doleva 3 = nahoru a 4 = dolu
	if pacman.boost == "no":
		skin.texture = load("res://.godot/imported/blinky.png-1e3ce8b2de40d1eaba8a997d57b72047.ctex")
		skibidi = 1
	if pacman.boost == "yes":
		skin.texture = load("res://pacman-art/ghosts/blue_ghost.png")
		skibidi = -1
	if position.x >= -9600:
		position.x = -25000
	if position.x  <= -25100:
		position.x = -9600
	if raycastdown.is_colliding() and raycastdown.get_collider() != null and raycastdown.get_collider().has_method("smrdim") :
		direction = 4
	if raycastleft.is_colliding() and  raycastleft.get_collider() != null and raycastleft.get_collider().has_method("smrdim") :
		direction = 2
	if raycastright.is_colliding() and raycastright.get_collider() != null and raycastright.get_collider().has_method("smrdim") :
		direction = 1
	if raycastup.is_colliding() and raycastup.get_collider() != null and raycastup.get_collider().has_method("smrdim") :
		direction = 3
	if direction == 1:
		position.x += SPEED*delta*skibidi
	if direction == 2:
		position.x -= SPEED*delta*skibidi
	if direction == 3:
		position.y -= SPEED*delta*skibidi
	if direction == 4:
		position.y += SPEED*delta*skibidi
	while reset:
		direction = randi() %4
		reset = false
		direction +=1
		SPEED /= -10
	
