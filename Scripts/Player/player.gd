extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
const  SPEED = 200
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const JUMP = -400.0

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
	
	
	move_and_slide()
	
func update_animation(delta):
	var input_x = Input.get_axis("ui_left",'ui_right')
	
	if is_on_floor():
		if input_x == 0 :
			sprite.play("iddle")
		elif input_x > 0:
			sprite.flip_h = false
			sprite.play("run")
		elif input_x < 0:
			sprite.flip_h = true
			sprite.play("run")
	
func jump(delta):
	if Input.is_action_just_pressed('jump') and is_on_floor():
		velocity.y = JUMP
		sprite.play("jump")
		
	elif not is_on_floor() and velocity.y > 0:
		sprite.play("fall")
