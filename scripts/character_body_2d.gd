extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycastup: RayCast2D = $raycastup
@onready var raycastright: RayCast2D = $raycastright
@onready var raycastdown: RayCast2D = $raycastdown
@onready var raycastleft: RayCast2D = $raycastleft
@onready var area_2d: Area2D = $Area2D
var status = "pacman"
var start_boost  = false
var boost = "no"
var crazy = true
var score = 0
var direction = " "
var lifes = 3
const SPEED = 1500
@onready var timer : Timer=$Timer
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("UP")and raycastup.is_colliding() == false:
		direction = "UP"
	if event.is_action_pressed("DOWN")and raycastdown.is_colliding() == false:
		direction = "DOWN"
	if event.is_action_pressed("LEFT")and raycastleft.is_colliding() == false:
		direction = "LEFT"
	if event.is_action_pressed("RIGHT")and raycastright.is_colliding() == false:
		direction = "RIGHT"
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_boost == true:
		start_boost = false
		timer.start()
		boost = "yes"
		
	if position.x >= -9600:
		position.x = -25000
	if position.x  <= -25100:
		position.x = -9600
	if score == 30:
		get_tree().change_scene_to_file("res://scenes/end.tscn")
	if lifes <= 0:
		get_tree().change_scene_to_file("res://scenes/control.tscn")
	$"../score".text = "your score: " + str(score) + "   lifes: " + str(lifes)
	if raycastleft.is_colliding() and direction == "LEFT" or raycastright.is_colliding() and direction == "RIGHT"or raycastup.is_colliding() and direction == "UP" or raycastdown.is_colliding() and direction == "DOWN":
		direction = ""
	if direction == "RIGHT" and raycastright.is_colliding() == false:
		position.x += SPEED*delta
		animated_sprite_2d.play("right")
	if direction == "LEFT" and raycastleft.is_colliding() == false:
		position.x -= SPEED*delta
		animated_sprite_2d.play("left")
	if direction == "UP"and raycastup.is_colliding() == false:
		position.y -= SPEED*delta
		animated_sprite_2d.play("up")
	if direction == "DOWN"and raycastdown.is_colliding() == false:
		position.y += SPEED*delta
		animated_sprite_2d.play("down")
	

	
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	direction = " "
	


func _on_pacmanborder_area_entered(area: Area2D) -> void:
	if area.has_method("dealdamage"):
		if boost == "no":
			lifes -= 1
		


func _on_timer_timeout() -> void:
	boost = "no"
	print("asdbkkkkdsada")
