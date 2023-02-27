.data 
	vector: .word 1,2,3            	#Introduce valores en el array vector 
	tama�o_vector: .word 3		
	matriz: .word 1,2,3,4,5,6,7,8,9	#Introduce los valores del array matriz	
	numero_columnas: .word 3
	numero_filas: .word 3
	incompatible: .asciiz "ERROR"		#Introduce en cierta direcci�n el texto "ERROR"
	vector_resultado: .space 12  		#Reserva un espacio de 12 bites en memoria.
.text 
.globl empezar				#Comienza el programa saltando a "empezar"
 
empezar:
	#Inicializamos todos los registros a 0 
	
	add $t0,$0,$0				
	add $t1,$0,$0			
	add $t2,$0,$0				
	add $t3,$0,$0			
	add $t4,$0,$0			
	add $t5,$0,$0				
	add $t6,$0,$0			
	add $t8,$0,$0
	
	add $s0,$0,$0
	add $s1,$0,$0
	add $s2,$0,$0
	add $s3,$0,$0
	add $s4,$0,$0 
	add $s5,$0,$0
	add $s7,$0,$0      
	
	#Asigna a los registros las direcciones de memoria de vector...
	
	la $t1,vector           
	la $t2,matriz 	
	lw $t3,tama�o_vector
	lw $t4,numero_filas		
	lw $t5,numero_columnas	
	la $s1,vector_resultado
	bne $t3,$t4,ERROR		#Verificamos que se puedan multiplicar matrix y vector viendo si la dimension del vector corresponde con el numero de filas
	
FOR:
	add $t8,$t8,1       #El contador guardado en $t8 incrementar� en 1 al iterar el bucle FOR
	
operacion:
	
	lw $s3,($t1)	#Asignamos en $s3 el valor donde se est� apuntanto en $t1
	lw $s4,($t2)	#Asignamos en $s4 el valor donde se est� apuntanto en $t2
	mul $s5,$s3,$s4	#$s5 guarda el valor de multiplicar $s3 y $s4
	add $s7,$s5,$s7     #En $s7 se guardar� la suma de $s5 y $s7
	mul $t0,$t5,4 	#Para saltar de fila en la matriz multiplicamos el numero de columnas por 4 y lo guardamos temporalmente en $t0
	add $t2,$t0,$t2	#Para sumar este incremento de posici�n, sumamos al vector de la matriz lo guardado temporlmente en $t0
	add $t1,$t1,4	#Para movernos en el vector a multiplicar le sumaremos 4	
	add $t6,$t6,1    	#Iniciamos otro contador a�andiendo al registro $t6 1
	bne $t6,$t4,operacion	#Para ver si ha llegado al fin de la columna, se compara el numero de filas con el numero del contador $t6, si no se cumple la condici�n se iterea el apartado de "operacion"		
	sw $s7,($s2)	#Se guarda una vez sumado los valores de la multiplicaci�n de la columna, el valor en el vector reservado en memoria $s2
	add $s2,$s2,4	#Se suma 4 a este vector de memoria vacio para pasar a la siguiente posici�n.
	la $t1,vector	#Se vuelve a asignar al $t1 la direcci�n de vector
	la $t2,matriz	#Se vuelve a asignar al $t2 la direcci�n de la matriz
	add $s7,$0,$0	#Se establece a cero el registro
	add $s5,$0,$0	#Se establece a cero el registro
	add $t6,$0,$0	#Se establece a cero el registro
	mul $s1,$t8,4	#Se multiplica el contador por 4 y se guarda en $s1
	add $t2,$t2,$s1	#Se suma al vector de la matriz el numero de posiciones anterior y que debe moverse
	bne $t8,$t5,FOR	#Si el valor del contador de $t8 corresponde con el numero de filas se pasar� a exit de lo contrario se repetir� el FOR.
							
exit:
	li $v0,10		#Al asignar al registro $vo el valor 10, se puede cerrar el programa
	syscall
	
ERROR:
	la $a0,incompatible 	#Se llama a incompatible para que muestre el texto por pantalla.
	li $v0,4 
	syscall	
	li $v0,10		#Se saldr� del programa.
	syscall			

