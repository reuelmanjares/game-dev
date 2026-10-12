extends Sprite2D

var clean_selected := false
var clean_finished := false
var watch_selected := false
var watch_finished := false
var eat_selected := false
var eat_finished := false
var bb_selected := false
var bb_finished := false

func _on_desk_area_body_entered(body: Node2D) -> void:
	if body == $Player and not eat_selected and not eat_finished and not watch_selected and not watch_finished and not clean_selected and not clean_finished and not bb_selected and not bb_finished:
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
	if GameData.remaining_time > 0:
		GameData.remaining_time -= delta
					
	var minutes := int(GameData.remaining_time / 60.0 ) 
	var seconds := int(GameData.remaining_time) % 60
							
	$"CanvasLayer/DayTimePanel/VBoxContainer/TimeLabel".text = "Remaining Time: %d:%02d" % [minutes, seconds]
		
func deduct_decision_time() -> void:
	GameData.remaining_time -= 90.0
	
	if GameData.remaining_time < 0:
		GameData.remaining_time = 0

func _on_hc_button_1_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	clean_selected = true
	
	$Broom1.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
	$CanvasLayer/HCbutton.visible = false

func _on_hc_area_body_entered(body: Node2D) -> void:
	if body == $Player and clean_selected: 
			$CanvasLayer/HCbutton.visible = true
			$Player.interaction_open = false
		
func _on_hc_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/HCbutton.visible = false
			
func _on_h_cbutton_pressed() -> void:
	$Broom1.material.set_shader_parameter("outline_color", Color(1, 0, 0, 0))
	
	$CanvasLayer/HCbutton.visible = false
	clean_selected = false
	clean_finished = true
	$"CanvasLayer/interact button".visible = false


func _on_wtv_button_2_pressed() -> void:
		deduct_decision_time()
		$"CanvasLayer/Choice Panel".visible = false
		$Player.interaction_open = false
		watch_selected = true
		
		$SofaAndTv.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
		$CanvasLayer/WatchButton.visible = false
		
func _on_watch_area_body_entered(body: Node2D) -> void:
		if body == $Player and watch_selected: 
			$CanvasLayer/WatchButton.visible = true
			$Player.interaction_open = false

func _on_watch_area_body_exited(body: Node2D) -> void:
	if body == $Player:
			$CanvasLayer/WatchButton.visible = false

func _on_watch_button_pressed() -> void:
	$SofaAndTv.material.set_shader_parameter("outline_color", Color(1, 0, 0, 0))
	$CanvasLayer/WatchButton.visible = false
	watch_selected = false
	watch_finished = true
	$"CanvasLayer/interact button".visible = false
						

func _on_eat_button_3_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	eat_selected = true
	
	$Table.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
	$CanvasLayer/EatButton.visible = false
	
func _on_eat_area_body_entered(body: Node2D) -> void:
	if body == $Player and eat_selected: 
		$CanvasLayer/EatButton.visible = true
		$Player.interaction_open = false

func _on_eat_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/EatButton.visible = false

func _on_eat_button_pressed() -> void:
	$Table.material.set_shader_parameter("outline_color", Color(1, 0, 0, 0))
	$CanvasLayer/EatButton.visible = false
	eat_selected = false
	eat_finished = true
	$"CanvasLayer/interact button".visible = false

func _on_bb_button_4_pressed() -> void:
	deduct_decision_time()
	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false
	bb_selected = true
	
	$BathroomDoor.material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
	$CanvasLayer/BBButton.visible = false

func _on_bb_area_body_entered(body: Node2D) -> void:
	if body == $Player and bb_selected: 
		$CanvasLayer/BBButton.visible = true
		$Player.interaction_open = false
								
func _on_bb_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/BBButton.visible = false

func _on_bb_button_pressed() -> void:
	$BathroomDoor.material.set_shader_parameter("outline_color", Color(1, 0, 0, 0))
	$CanvasLayer/BBButton.visible = false
	bb_selected = false
	bb_finished = true
	$"CanvasLayer/interact button".visible = false
						
