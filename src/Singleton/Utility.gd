extends Node

var current_stage = 1

#stage 1
signal pickup_mask
var mask_pickup = 0 setget pick

#stage2
signal pick_up_tool
# 1. Laptop, Book, Bolpoint
var tool_pickup = [0,0,0] setget pick_tool

#stage3
signal pick_sanitizer
var sanitizer_pick = 0 setget pick_sanitizer  

signal object_crash

#stage5
signal pick_soap
var soap_pick = 0 setget pick_soap  


func pick(mask):
	mask_pickup = mask
	emit_signal("pickup_mask")

func pick_tool(new_tool_pickup):
	tool_pickup = new_tool_pickup
	emit_signal("pick_up_tool")

func pick_sanitizer(new_value):
	sanitizer_pick = new_value
	emit_signal("pick_sanitizer")

func pick_soap(new_soap_value):
	soap_pick = new_soap_value
	emit_signal("pick_soap")
