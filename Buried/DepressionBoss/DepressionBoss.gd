extends Node2D

const Chain = preload("res://Chain/Chain.gd")

export var chain_prefab : PackedScene
export var chain_target_path : NodePath
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var total_number_of_chains = 0
var current_number_of_chains = 0
var current_chains : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if (current_number_of_chains < total_number_of_chains):
		var chain = chain_prefab.instance()
		get_tree().get_root().add_child(chain)
		chain.chain_origin = global_position
		chain.chain_target_path = chain_target_path
		current_chains.append(chain)
	else:
		for i in current_chains:
			current_chains[i].chain_mode = Chain.ChainMode.Returning
			# Note need to free chains here or in Chain.gd
		current_chains.clear()
		current_number_of_chains = 0
		
