#Meteorito.gd
class_name Meteorito
extends RigidBody2D

#Atributos export
export var vel_lineal_base:Vector2 = Vector2(300.0, 300.0)
export var vel_ang_base:float = 3.0
export var hitpoints_base:float = 10.0

#Atributos
var hitpoints:float
var tamanio:int


#Metodos
func _ready() -> void:
	angular_velocity = vel_ang_base
	
#Metodos custom
func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0:
		destruir()
		
	#impacto_sfx.play()
		
func destruir() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
	
#Constructor
func crear(pos: Vector2, dir:Vector2) -> void:
	position = pos
	#Calcular Masa, tamaño de sprite y de colisionador
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio 
	#radio = diametro / 2
	var radio:int = int($Sprite.texture.get_size().x / 2 * tamanio)
	var forma_colision:CircleShape2D = CircleShape2D.new()
	forma_colision.radius = radio
	$CollisionShape2D.shape = forma_colision
	#calcular velocidades
	linear_velocity = vel_lineal_base * dir / tamanio
	angular_velocity = vel_ang_base / tamanio
	#Calcular hitpoints
	hitpoints = hitpoints_base * tamanio
	#solo debug
	print("hitpoints: ", hitpoints)
	
	
	
	
	
	
	
	 


