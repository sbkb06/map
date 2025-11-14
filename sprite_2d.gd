extends CharacterBody2D

@export var speed := 200
@export var jump_velocity := -400
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	# الجاذبية
	if not is_on_floor():
		velocity.y += gravity * delta

	# حركة يمين ويسار
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * speed
		$AnimatedSprite2D.flip_h = direction < 0
		$AnimatedSprite2D.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		$AnimatedSprite2D.play("idle")

	# قفز
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		$AnimatedSprite2D.play("jump")

	move_and_slide()
