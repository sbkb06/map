extends Node2D

func _ready():
	print("Game Started")

	# تشغيل أنميشن idle لكل الأعداء بالبداية
	for child in get_children():
		if "enemy" in child.name:
			if child.has_node("AnimatedSprite2D"):
				var anim = child.get_node("AnimatedSprite2D")
				if anim.has_animation("idle"):
					anim.play("idle")
