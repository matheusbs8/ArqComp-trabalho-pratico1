.data
A: .word 3, 2  # Array A com espa�o para 9 inteiros
tamanho: .word 2            # Vari�vel tamanho para armazenar o tamanho do array

.text
.globl main

main:
	# Carregando o tamanho do array na vari�vel $t0
    	lw $t0, tamanho
    	lw $a0, A

    	# Inicializando o �ndice do menor elemento com 0
    	add $t1, $zero, $zero
      	add $t2, $zero, $zero        # $t2 � o �ndice i


for_i_loop:
  # Inicializa o �ndice do menor elemento com o �ndice atual
  move $t1, $t2

  # Inicia a compara��o com o pr�ximo elemento
  addi $t3, $t2, 1

for_j_loop:
  # Carrega o elemento atual (A[$t2])
  lw $t4, 0($a0)        

  # Carrega o pr�ximo elemento (A[$t3])
  lw $t5, 0($a0)         

  # Compara os elementos
  bge $t4, $t5, skip_swap  # Se A[$t2] >= A[$t3], pule para skip_swap

  # Se A[$t2] < A[$t3], atualiza o �ndice do menor elemento
  move $t1, $t3

skip_swap:
  # Incrementa $t3 para comparar com o pr�ximo elemento
  addi $t3, $t3, 1

  # Verifica se o �ndice atual ($t3) � menor que o tamanho do array ($t0)
  blt $t3, $t0, for_j_loop  # Se $t3 < $t0, continue o loop interno

  # Swap: Troca A[$t2] com o menor elemento A[$t1]
  lw $t4, 0($a0)          # Carrega A[$t2] novamente
  lw $t5, 0($a0)          # Carrega A[$t1]
  sw $t5, 0($a0)          # Armazena A[$t1] em A[$t2]
  sw $t4, 0($a0)          # Armazena A[$t2] em A[$t1]

  # Incrementa o �ndice atual ($t2)
  addi $t2, $t2, 1

  # Verifica se o �ndice atual ($t2) � menor que o tamanho do array ($t0)
  blt $t2, $t0, for_i_loop  # Se $t2 < $t0, continue o loop externo

# Fim da ordena��o por sele��o

 
	
	