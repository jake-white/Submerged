class_name DDRInput
extends RefCounted
var actionIndex
var joypadIndex
var indexStr

func _init(a, j):
	self.actionIndex = a
	self.joypadIndex = j
	indexStr = str(actionIndex)
	
	var upAction = InputEventJoypadButton.new()
	upAction.device = joypadIndex
	upAction.button_index = 0
	InputMap.action_add_event("up"+indexStr, upAction)
	var downAction = InputEventJoypadButton.new()
	downAction.device = joypadIndex
	downAction.button_index = 1
	InputMap.action_add_event("down"+indexStr, downAction)
	var leftAction = InputEventJoypadButton.new()
	leftAction.device = joypadIndex
	leftAction.button_index = 2
	InputMap.action_add_event("left"+indexStr, leftAction)
	var rightAction = InputEventJoypadButton.new()
	rightAction.device = joypadIndex
	rightAction.button_index = 3
	InputMap.action_add_event("right"+indexStr, rightAction)

	var upLeftAction = InputEventJoypadButton.new()
	upLeftAction.device = joypadIndex
	upLeftAction.button_index = 4
	InputMap.action_add_event("upleft"+indexStr, upLeftAction)
	var upRightAction = InputEventJoypadButton.new()
	upRightAction.device = joypadIndex
	upRightAction.button_index = 5
	InputMap.action_add_event("upright"+indexStr, upRightAction)
	var downLeftAction = InputEventJoypadButton.new()
	downLeftAction.device = joypadIndex
	downLeftAction.button_index = 6
	InputMap.action_add_event("downleft"+indexStr, downLeftAction)
	var downRightAction = InputEventJoypadButton.new()
	downRightAction.device = joypadIndex
	downRightAction.button_index = 7
	InputMap.action_add_event("downright"+indexStr, downRightAction)
	var middleAction = InputEventJoypadButton.new()
	middleAction.device = joypadIndex
	middleAction.button_index = 8
	InputMap.action_add_event("middle"+indexStr, middleAction)

func GetVector():
	var horizontal = (1 if Input.is_action_pressed("right"+indexStr) else 0) - (1 if Input.is_action_pressed("left"+indexStr) else 0)
	var vertical = (1 if Input.is_action_pressed("up"+indexStr) else 0) - (1 if Input.is_action_pressed("down"+indexStr) else 0)
	return Vector2(horizontal, vertical)

func GetMiddle():
	return Input.is_action_just_pressed("middle"+indexStr)

func GetCorner(cornerIndex):
	var action = ""
	match(cornerIndex):
		0:
			action = "upleft"
		1:
			action = "upright"
		2:
			action = "downleft"
		3:
			action = "downright"
	return Input.is_action_just_pressed(action+indexStr)

func GetOtherState(otherIndex):
	var action = ""
	match(otherIndex):
		0:
			action = "upleft"
		1:
			action = "upright"
		2:
			action = "downleft"
		3:
			action = "downright"
		4:
			action = "middle"
	return Input.is_action_pressed(action+indexStr)
		