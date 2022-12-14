extends KinematicBody

# stats
var health : int = 5
var moveSpeed : float = 1.0
# attacking
var damage : int = 1
var attackRate : float = 1.0
var attackDist : float = 2.0
var scoreToGive : int = 10
# components
onready var player : Node = get_node("/root/MainScene/Player")
onready var timer : Timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	# setup the timer
	timer.set_wait_time(attackRate)
	timer.start()

func _on_Timer_timeout ():
# if we're at the right distance, attack the player
	if translation.distance_to(player.translation) <= attackDist:
		attack()
		
func _physics_process ():
	# calculate direction to the player
	var dir = (player.translation - translation).normalized()
	dir.y = 0
	# move the enemy towards the player
	move_and_slide(dir * moveSpeed, Vector3.UP)

# called when we get damaged by the player
func take_damage (damage):
	health -= damage
	# if we've ran out of health - die
	if health <= 0:
		die()
		
func die ():
	player.add_score(scoreToGive)
	queue_free()
	
# deals damage to the player
func attack ():
	player.take_damage(damage)
