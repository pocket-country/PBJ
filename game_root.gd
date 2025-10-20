extends Node
##
## Top level script.  Currently functioning a 'global space (no autoload)
##

@onready var UI = $UI

# note: all these variables correspond to metrics displayed on the status bar
# we will rationalize nameing later ... 
# and 'balance' later
# 1) four supply levels (unknown units)
var bread: int = 99					# maybe make 99 a sentinal for infinite?
var peanut_butter: int = 20;		#
var marmalade: int = 10				# assumed to be orange marmalade
var strawberry: int = 10			# assumed to be strawberry jam, not jelly!

# 2) three intermediate product (slices) counts - number of object in game
# (so controlled by game world logic)
var pb_slices: int = 0
var marmalade_slices: int = 0
var strawberry_slices: int = 0

# 3) two final outputs 
var sandwich_count: int = 0			# number of objects in game controled by game world
var coins: int = 0					# no sales dynamic yet, placeholder

# 4) day counter
var day: int = 1					# currently placeholder



func _ready():
	pass
	# initialize status bar display.  This really crys out for having
	# all the metrics above in a dict with keys that match display node 
	# names, common guy! TODO
	#UI.update_metric("BD", bread)
	#UI.update_metric("PB", peanut_butter)
	#UI.update_metric("OM", marmalade)
	#UI.update_metric("SJ", strawberry)	
	#UI.update_metric("PBS", pb_slices)
	#UI.update_metric("OMS", marmalade_slices)
	#UI.update_metric("SJS", strawberry_slices)
	#UI.update_metric("SWCH", sandwich_count)
	#UI.update_metric("COIN", coins)
	
	
