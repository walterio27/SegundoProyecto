#Player.gd
extends RigidBody2D
class_name Player

## Atributos export
export var potencia_motor:int = 20
export var potencia_rotacion:int = 280

## Atributos
var empuje:Vector2 = Vector2.ZERO
var dir_rotacion:int = 0

## Atributos OnReady
onready var Canion:Canion = $Canion
onready var laser:RayoLaser = $LaserBeam2D


## Metodos
func _unhandled_input(event: InputEvent) -> void:
	#Disparo Rayo
	if event.is_action_pressed("disparo_secundario"):
		laser.set_is_casting(true)
		
	if event.is_action_released("disparo_secundario"):
		laser.set_is_casting(false)
	

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	#Los prints son solo para entender mejor que esta pasando. BORRAR
	print(rad2deg(rotation))
	print(empuje.rotated(rotation))
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion * potencia_rotacion)
	
func _process(delta: float) -> void:
	player_input()
## Metodos Custom
func player_input() -> void:
	# Empuje
	empuje = Vector2.ZERO
	if Input.is_action_pressed("mover_adelante"):
		empuje = Vector2(potencia_motor, 0)
	elif Input.is_action_pressed("mover_atras"):
		empuje = Vector2(-potencia_motor, 0)
		
	# Rotacion
	dir_rotacion = 0
	if Input.is_action_pressed("rotar_antihorario"):
		dir_rotacion -= 1
	elif Input.is_action_pressed("rotar_horario"):
		dir_rotacion += 1
	
	# Disparo
	if Input.is_action_pressed("disparo_principal"):
		Canion.set_esta_disparando(true)
		
	if Input.is_action_just_released("disparo_principal"):
		Canion.set_esta_disparando(false)
			

	
			
		
	
		

	


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
