extends CharacterBody2D

const SPEED := 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# false = original left-facing
# true = flipped/right-facing
var facing_right := false

# Mobile touch direction
var touch_direction := 0
var near_bed := false

func _physics_process(_delta: float) -> void:
		# PC keyboard movement
			var direction := Input.get_axis("ui_left", "ui_right")
			
			if touch_direction != 0:
				direction = touch_direction
								
			velocity.x = direction * SPEED
			
			if direction != 0.0:
				if direction < 0.0:
					sprite.flip_h = false
					facing_right= false
					
				elif direction > 0.0:
					sprite.flip_h = true
					facing_right = true
											
				sprite.play("walk")
			else:
				sprite.stop()
				sprite.frame = 0
				sprite.flip_h = facing_right
																							
			move_and_slide()
																								
																								
func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			var screen_width := get_viewport().get_visible_rect().size.x
																																		
			if event.position.x < screen_width / 2:
				touch_direction = -1
																																													
			else:
				touch_direction = 1
																																																								
		else:
			touch_direction = 0
