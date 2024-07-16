extends Node

@export var stalactite_prefab: PackedScene
@export var falling_stalactite_interval: float
@export var stalactite_num : int
var stalactite_textures = []

func _ready():
	# Setting Timer wait time
	$Timer.wait_time = falling_stalactite_interval
	# Loading textures
	for i in range(1, 10):
		stalactite_textures.append(load("res://Assets/depression/stalactite/rock" + str(i) + ".png"))
	# Spawning stalactites
	for i in range(0, stalactite_num):
		var stalactite = stalactite_prefab.instantiate()
		var texture = stalactite_textures[randi_range(0, len(stalactite_textures) - 1)]
		add_child(stalactite)
		stalactite.position.x = randf_range(0, 3840)
		stalactite.position.y = texture.get_height() / 2.0
		stalactite.get_node("Sprite2D").texture = texture
		stalactite.set_component_rects()

func _process(delta):
	pass

func _on_timer_timeout():
	make_stalactite_fall()

# This function makes a stalactite fall from children of this object.
# This function also makes sure the stalactite selected is eligible to switch to the Fall state.
func make_stalactite_fall(tries = 5):
	if (tries == 0):
		return
	var child = get_child(randi_range(0,get_child_count() - 1))
	if child.name == "Timer":
		make_stalactite_fall(tries - 1)
		return
	if not child.set_stage_to_falling():
		make_stalactite_fall(tries - 1)
		return
