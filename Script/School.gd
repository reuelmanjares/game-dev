extends Sprite2D

var lt_selected := false
var lt_finished := false
var cmate_selected := false
var cmate_finished := false
var chair_selected := false
var chair_finished := false
var C_selected := false
var C_finished := false


func _ready() -> void:
	# Initial character visibility.
	$RyanListening.visible = true
	$CChar.visible = false

	# Hide interaction buttons at the start.
	$CanvasLayer/CmateButton.visible = false
	$CanvasLayer/LTButton.visible = false
	$CanvasLayer/NapButton.visible = false
	$CanvasLayer/SCButton.visible = false


# OUTLINE HELPER
func _set_outline(target: CanvasItem, enabled: bool) -> void:
	if target == null:
		push_error("Node not found. Check the node path.")
		return

	var shader_mat := target.material as ShaderMaterial

	if shader_mat == null:
		push_error("Missing ShaderMaterial on node: " + str(target.name))
		return

	var outline_color := (
		Color(1, 0, 0, 1)
		if enabled
		else Color(1, 0, 0, 0)
	)

	shader_mat.set_shader_parameter("outline_color", outline_color)


# DESK INTERACTION
func _on_desk_area_body_entered(body: Node2D) -> void:
	if body != $Player:
		return

	if (
		not lt_selected
		and not lt_finished
		and not chair_selected
		and not chair_finished
		and not C_selected
		and not C_finished
		and not cmate_selected
		and not cmate_finished
	):
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


# REMAINING TIME
func _process(delta: float) -> void:
	GameData.remaining_time = maxf(
		GameData.remaining_time - delta,
		0.0
	)

	var minutes := int(GameData.remaining_time / 60.0)
	var seconds := int(GameData.remaining_time) % 60

	$"CanvasLayer/DayTimePanel/VBoxContainer/TimeLabel".text = (
		"Remaining Time: %d:%02d" % [minutes, seconds]
	)


func deduct_decision_time() -> void:
	GameData.remaining_time = maxf(
		GameData.remaining_time - 90.0,
		0.0
	)


# LT / CHAIR
func _on_lt_button_1_pressed() -> void:
	deduct_decision_time()

	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false

	lt_selected = true

	_set_outline($chair1, true)
	$CanvasLayer/LTButton.visible = false


func _on_lt_area_body_entered(body: Node2D) -> void:
	if body == $Player and lt_selected:
		$CanvasLayer/LTButton.visible = true
		$Player.interaction_open = false


func _on_lt_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/LTButton.visible = false


func _on_lt_button_pressed() -> void:
	_set_outline($chair1, false)

	$CanvasLayer/LTButton.visible = false

	lt_selected = false
	lt_finished = true

	$"CanvasLayer/interact button".visible = false


# CLASSMATE / RYAN
# Called when the CM choice is selected.
func _on_cmate_button_2_pressed() -> void:
	deduct_decision_time()

	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false

	cmate_selected = true

	# Hide the seated Ryan.
	$RyanListening.visible = false

	# Find the Marker2D in front of the player.
	var talk_position := get_node_or_null(
		"Player/RyanTalkPosition"
	) as Marker2D

	if talk_position != null:
		$CChar.global_position = talk_position.global_position
	else:
		push_error(
			"RyanTalkPosition not found. Add a Marker2D under Player."
		)

	# Show the standing Ryan.
	$CChar.visible = true

	# Show the ETalk button.
	$CanvasLayer/CmateButton.visible = true


# Show ETalk when the player enters the classmate area.
func _on_cmate_area_body_entered(body: Node2D) -> void:
	if body == $Player and cmate_selected:
		$CanvasLayer/CmateButton.visible = true
		$Player.interaction_open = false


func _on_cmate_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/CmateButton.visible = false


# Called when ETalk is pressed.
func _on_cmate_button_pressed() -> void:
	# Hide the standing Ryan.
	$CChar.visible = false

	# Bring back the seated Ryan.
	$RyanListening.visible = true

	# Hide ETalk.
	$CanvasLayer/CmateButton.visible = false

	cmate_selected = false
	cmate_finished = true

	$"CanvasLayer/interact button".visible = false
	$Player.interaction_open = false


# NAP / CHAIR
func _on_nap_button_3_pressed() -> void:
	deduct_decision_time()

	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false

	chair_selected = true

	_set_outline($chair1, true)
	$CanvasLayer/NapButton.visible = false


func _on_nap_area_body_entered(body: Node2D) -> void:
	if body == $Player and chair_selected:
		$CanvasLayer/NapButton.visible = true
		$Player.interaction_open = false


func _on_nap_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/NapButton.visible = false


func _on_nap_button_pressed() -> void:
	_set_outline($chair1, false)

	$CanvasLayer/NapButton.visible = false

	chair_selected = false
	chair_finished = true

	$"CanvasLayer/interact button".visible = false


# SCHOOL DOOR
func _on_sc_button_4_pressed() -> void:
	deduct_decision_time()

	$"CanvasLayer/Choice Panel".visible = false
	$Player.interaction_open = false

	C_selected = true

	_set_outline($SchoolDoor, true)
	$CanvasLayer/SCButton.visible = false


func _on_sc_area_body_entered(body: Node2D) -> void:
	if body == $Player and C_selected:
		$CanvasLayer/SCButton.visible = true
		$Player.interaction_open = false


func _on_sc_area_body_exited(body: Node2D) -> void:
	if body == $Player:
		$CanvasLayer/SCButton.visible = false


func _on_sc_button_pressed() -> void:
	_set_outline($SchoolDoor, false)

	$CanvasLayer/SCButton.visible = false

	C_selected = false
	C_finished = true

	$"CanvasLayer/interact button".visible = false
