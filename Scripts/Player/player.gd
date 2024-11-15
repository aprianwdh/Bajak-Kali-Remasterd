extends CharacterBody2D

@onready var sprite = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@export var atacking = false

const  SPEED = 200
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP = -400.0

@onready var state
@onready var sword_overlaping = $atack_area/sword_overlaping

func _physics_process(delta):
	var input_x = Input.get_axis("ui_left",'ui_right')
	
	#add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#menjalankan karakter
	velocity.x = input_x * SPEED
	
	#fungsi update animation
	update_animation(delta)
	jump(delta)
	atack(delta)
	
	
	move_and_slide()
	
func update_animation(delta):
	var input_x = Input.get_axis("ui_left",'ui_right')
	
	if atacking == false:
		if is_on_floor():
			if input_x == 0 :
				sprite.play("iddle")
			elif input_x > 0:
				sprite_2d.flip_h = false
				sprite.play("run")
				sword_overlaping.position.x = abs(position.x)
			elif input_x < 0:
				sprite_2d.flip_h = true
				sprite.play("run")
				sword_overlaping.position.x = -abs(position.x)
	
func jump(delta):
	if Input.is_action_just_pressed('jump') and is_on_floor():
		velocity.y = JUMP
		sprite.play("jump")
		
	elif not is_on_floor() and velocity.y > 0:
		sprite.play("fall")
		
func atack(_delta):
	if Input.is_action_just_pressed("ui_down"):
		$AnimationPlayer.play("atack")
		atacking = true
