extends CharacterBody2D

@export var speed := 40
@export var gravity := 600
var direction := 1
var dead := false

func _physics_process(delta):
	if dead:
		return

	velocity.y += gravity * delta
	velocity.x = direction * speed

	var collision_info = move_and_slide()

	# لو خبط في حيطة -> قلب الاتجاه
	if is_on_wall():
		direction = -direction
		$AnimatedSprite2D.flip_h = direction < 0

	# لو ما في أرض قدامه -> قلب الاتجاه
	if not is_on_floor():
		direction = -direction
		velocity.x = direction * speed
		$AnimatedSprite2D.flip_h = direction < 0

	# أنميشن
	$AnimatedSprite2D.play("walk")


func die():
	dead = true
	velocity = Vector2.ZERO
	if $AnimatedSprite2D.has_animation("death"):
		$AnimatedSprite2D.play("death")
	await get_tree().create_timer(0.5).timeout
	queue_free()
