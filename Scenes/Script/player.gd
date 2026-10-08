class_name PlayerChar extends CharacterBody2D


@export var run_speed := 280.0
@export var acceleration := 2200.0
@export var deceleration := 2200.0
@export var jump_speed := 430.0
@export var gravity := 1350.0

@export var coyote_time := 0.62
var coyote_left := 0.0

func update_coyote_time(delta: float) -> void:
	if is_on_floor():
		coyote_left = coyote_time
	else:
		coyote_left = maxf(coyote_left - delta, 0.0)

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("move_left", "move_right")
	var target_speed := direction * run_speed
	var rate := acceleration if direction != 0.0 else deceleration
	
	velocity.x = move_toward(velocity.x, target_speed, rate * delta)
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = -jump_speed
		
	move_and_slide()
	
	
		
	if not is_on_floor():
		$AnimatedSprite2D.play("up")
	else: 
		if velocity.x != 0:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = velocity.x < 0
		else:
			$AnimatedSprite2D.play("idle")
			
#https://docs.godotengine.org/en/stable/getting_started/first_2d_game/04.creating_the_enemy.html
