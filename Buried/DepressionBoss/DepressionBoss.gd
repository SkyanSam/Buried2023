extends Node2D

const Chain = preload("res://Chain/Chain.gd")

export var chain_prefab : PackedScene
export var chain_target_path : NodePath

export var total_number_of_chains = 0
var current_number_of_chains = 0
var current_chains : Array



func _on_Timer_timeout():
	if (current_number_of_chains < total_number_of_chains):
		# Create a chain
		var chain = chain_prefab.instance()
		# Set chain variables
		chain.chain_origin = global_position
		chain.chain_target_path = chain_target_path
		# Add chain to list
		current_chains.append(chain)
		get_parent().add_child(chain)
	else:
		# Return all chains once the max # of chains is reached
		for i in current_chains:
			current_chains[i].chain_mode = Chain.ChainMode.Returning
			# Note need to free chains here or in Chain.gd
		current_chains.clear()
		current_number_of_chains = 0
		
