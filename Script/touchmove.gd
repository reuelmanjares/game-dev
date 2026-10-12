extends CharacterBody2D

@export var speed: float = 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var touch_direction := 0
var facing_right := false
var interaction_open := false

func _physics_process(_delta: float) -> void:
		if interaction_open:
			velocity.x = 0
			touch_direction = 0
			sprite.stop()
			move_and_slide()
			return
		
		var direction := Input.get_axis("move_left", "move_right")
		
		if touch_direction != 0:
			direction = touch_direction
							
		if direction != 0:
			velocity.x = direction * speed
											
			if direction < 0:
				sprite.flip_h = false
				facing_right = false
																						
			else:
				sprite.flip_h = true
				facing_right = true
				
			sprite.play("walk")
			
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
							
			sprite.stop()
			sprite.frame = 0
			sprite.flip_h = facing_right
															
		velocity.y = 0
		move_and_slide()
																	
																	
func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			var screen_width = get_viewport().get_visible_rect().size.x
																										
			if event.position.x < screen_width / 2:
				touch_direction = -1
			else:
				touch_direction = 1
		else:
			touch_direction = 0
