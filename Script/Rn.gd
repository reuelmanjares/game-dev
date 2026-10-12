extends Sprite2D

var ass_selected := false
var ass_finished := false
var cb_selected := false
var cb_finished := false
var bath_selected := false
var bath_finished := false
var sleep_selected := false
var sleep_finished := false

func _on_desk_area_body_entered(body: Node2D) -> void:
	if body == $Player and not ass_selected and not ass_finished and not cb_selected and not cb_finished and not bath_selected and not bath_finished and not sleep_selected and not sleep_finished:
		$"CanvasLayer/interact button".visible = true
						

func _on_desk_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$"CanvasLayer/interact button".visible = false

func _on_interact_button_pressed() -> void:
	$Player.interaction_open = true
	$"CanvasLayer/interact button".visible = false
	$"CanvasLayer/Choice Panel".visible = true

func _on_back_button_pressed() -> void:
	$"CanvasLayer/Choice Panel".visible = false
	$"CanvasLayer/interact button".visible = true
	$Player.interaction_open = false

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

func _on_ass_button_1_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	ass_selected = true
	
	$Table.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
	$CanvasLayer/AssButton.visible = false

func _on_ass_area_body_entered(body: Node2D) -> void:
	if body == $Player and ass_selected:
		$CanvasLayer/AssButton.visible = true
		$Player.interaction_open = false

func _on_ass_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/AssButton.visible = false

func _on_ass_button_pressed() -> void:
	$Table.material.set_shader_parameter("outline_color", Color(1, 0, 0, 0)) 
	$CanvasLayer/AssButton.visible = false
	ass_selected = false
	ass_finished = true
	$"CanvasLayer/interact button".visible = false

func _on_cb_button_2_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	cb_selected = true
		
	$CoffeeAndBread.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
	$CoffeeAndBread.visible = true
	$CanvasLayer/CBButton.visible = false
			
		
func _on_cb_area_body_entered(body: Node2D) -> void:
	if body == $Player and cb_selected: 
		$CanvasLayer/CBButton.visible = true
		$Player.interaction_open = false
				
				
func _on_cb_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/CBButton.visible = false
					
func _on_cb_button_pressed() -> void:
	$CoffeeAndBread.material.set_shader_parameter("outline_color", Color(1, 0, 0, 0))
	$CoffeeAndBread.visible = false
	$CanvasLayer/CBButton.visible = false
	cb_selected = false
	cb_finished = true
	$"CanvasLayer/interact button".visible = false
		





func _on_bb_button_3_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	bath_selected = true
	bath_finished = false
	$BathArrow.visible = true

func _on_bath_area_body_entered(body: Node2D) -> void:
	if body == $Player and bath_selected and not bath_finished:
		$CanvasLayer/BathButton.visible = true
		$Player.interaction_open = false

func _on_bath_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/BathButton.visible = false

func _on_bath_button_pressed() -> void:
	$CanvasLayer/BathButton.visible = false
	$BathArrow.visible = false
	bath_selected = false
	bath_finished = true
	$"CanvasLayer/interact button".visible = false

func _on_s_button_4_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	sleep_selected = true
					
	$Bed.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
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
	$CanvasLayer/BedButton.visible = false
	sleep_selected = false
	sleep_finished = true
	$"CanvasLayer/interact button".visible = false
