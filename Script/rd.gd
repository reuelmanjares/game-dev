extends Sprite2D

var cellphone_selected := false
var phone_clicked := false
var sleep_selected := false
var sleep_finished := false
var exercise_selected := false
var exercise_finished := false
var clean_selected := false
var clean_finished := false

func _on_desk_area_body_entered(body: Node2D) -> void:
	if body == $Player and not cellphone_selected and not sleep_selected and not sleep_finished and not exercise_selected and not exercise_finished and not clean_selected and not clean_finished:
		$"CanvasLayer/interact button".visible = true
		
func _on_desk_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$"CanvasLayer/interact button".visible = false

#for E interact
func _on_interact_button_pressed() -> void:
	$Player.interaction_open = true
	$"CanvasLayer/interact button".visible = false
	$"CanvasLayer/Choice Panel".visible = true

#for Back 
func _on_back_button_pressed() -> void:
	$"CanvasLayer/Choice Panel".visible = false
	$"CanvasLayer/interact button".visible = true
	$Player.interaction_open = false

#for choice button 1
func _on_s_button_1_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	sleep_selected = true
	
	$Bed.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
	$CanvasLayer/BedNotification.visible = true
	$CanvasLayer/BedButton.visible = false

func _on_bed_area_body_entered(body: Node2D) -> void:
	if body == $Player and sleep_selected: 
		$CanvasLayer/BedButton.visible = true
		$Player.interaction_open = false
		
func _on_bed_area_body_exited(body: Node2D) -> void:
		if body == $Player:
			$CanvasLayer/BedButton.visible = false

func _on_bed_button_pressed() -> void:
	$Bed.material.set_shader_parameter("outline_color", Color(1, 0, 0, 0))
	$CanvasLayer/BedNotification.visible = false
	$CanvasLayer/BedButton.visible = false
	sleep_selected = false
	sleep_finished = true
	$"CanvasLayer/interact button".visible = false
	
#for choice button 2
func _on_clean_button_2_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	clean_selected = true
	
	$Broom1.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
	
	$CanvasLayer/CleanButton.visible = false

func _on_clean_area_body_entered(body: Node2D) -> void:
	if body == $Player and clean_selected: 
		$CanvasLayer/CleanButton.visible = true
		$Player.interaction_open = false
		
		
func _on_clean_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/CleanButton.visible = false
	
func _on_clean_button_pressed() -> void:
	$Broom1.material.set_shader_parameter("outline_color", Color(1, 0, 0, 0))
	
	$CanvasLayer/CleanButton.visible = false
	clean_selected = false
	clean_finished = true
	$"CanvasLayer/interact button".visible = false

#for choice button 3
func _on_cp_button_3_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false 
	$Player.interaction_open = false
	cellphone_selected = true
	phone_clicked = false
	$Phone.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1)) 
	$CanvasLayer/PhoneNotification.visible = true
	$CanvasLayer/PhoneButton.visible = false

func _on_phone_area_body_entered(body: Node2D) -> void:
	if body == $Player and cellphone_selected and not phone_clicked:
		$CanvasLayer/PhoneButton.visible = true
		$Player.interaction_open = false

func _on_phone_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/PhoneButton.visible = false
	
func _on_phone_button_pressed() -> void:
	$CanvasLayer/PhoneNotification.visible = false
	$CanvasLayer/PhoneButton.visible = false
	$Phone.material.set_shader_parameter("outline_color", Color(1, 0, 0, 0))
	phone_clicked = true

func _process(delta: float) -> void:
	GameData.remaining_time -= delta
			
	if GameData.remaining_time < 0:
		GameData.remaining_time = 0
								
	var minutes := int(GameData.remaining_time / 60.0)
	var seconds := int(GameData.remaining_time) % 60
											
	$"CanvasLayer/DayTimePanel/VBoxContainer/TimeLabel".text = "Remaining Time: %d:%02d" % [minutes, seconds]
			
func deduct_decision_time() -> void:
	GameData.remaining_time -= 90.0
						
	if GameData.remaining_time < 0:
		GameData.remaining_time = 0


func _on_e_button_4_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	exercise_selected = true
	exercise_finished = false
	$ExerciseArrow.visible = true


func _on_exercise_area_body_entered(body: Node2D) -> void:
	if body == $Player and exercise_selected and not exercise_finished:
		$CanvasLayer/ExerciseButton.visible = true
		$Player.interaction_open = false

func _on_exercise_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/ExerciseButton.visible = false


func _on_exercise_button_pressed() -> void:
	$CanvasLayer/ExerciseButton.visible = false
	$ExerciseArrow.visible = false
	exercise_selected = false
	exercise_finished = true
	$"CanvasLayer/interact button".visible = false
