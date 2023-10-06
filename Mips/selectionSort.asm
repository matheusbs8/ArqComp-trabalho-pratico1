.data
A: .word 3, 2, 7, 8, 1, 9, 10, 4, 7, 99  # Array A com elementos
tamanho: .word 10  # Vari�vel tamanho para armazenar o tamanho do array

.text
.globl main

main:
  # Carregando o tamanho do array na vari�vel $a1
  lw $a1, tamanho
  la $a0, A

  # Chama a fun��o de ordena��o por sele��o
  jal selection_sort

  # Sa�da do programa
  j exit

selection_sort:
  # Inicializando o �ndice do menor elemento (t1) com 0
  li $t1, 0
  li $t2, 0  # $t2 � o �ndice i

for_i_loop:
  # Inicializa o �ndice do menor elemento com o �ndice atual
  move $t1, $t2

  # Inicia o �ndice j a partir de i+1
  add $t8, $t2, 1

for_j_loop:
  # Carregando o endere�o de A[j] (eleito)
  sll $t4, $t8, 2   # Multiplicando $t8 por 4 (tamanho de um elemento)
  add $t4, $a0, $t4  # $t4 cont�m o endere�o de A[j]
  # Carregando A[j] (eleito) na vari�vel $t5
  lw $t5, 0($t4)  # $t5 cont�m A[j]

  # Carregando o endere�o de A[indiceMenor] (eleito)
  sll $t6, $t1, 2   # Multiplicando $t1 por 4 (tamanho de um elemento)
  add $t6, $a0, $t6  # $t6 cont�m o endere�o de A[indiceMenor]
  # Carregando A[indiceMenor] (eleito) na vari�vel $t7
  lw $t7, 0($t6)  # $t7 cont�m A[indiceMenor]

  # Compara os elementos
  bge $t5, $t7, skip_swap  # Se A[j] >= A[indiceMenor], pule para skip_swap

  # Se A[j] < A[indiceMenor], atualiza o �ndice do menor elemento
  move $t1, $t8

skip_swap:
  # Incrementa $t8 para comparar com o pr�ximo elemento
  addi $t8, $t8, 1

  # Verifica se o �ndice atual ($t8) � menor que o tamanho do array ($a1)
  blt $t8, $a1, for_j_loop  # Se j < tam, continue o loop interno

  # Swap: Troca A[i] com o menor elemento A[indiceMenor]
  sll $t7, $t2, 2   # Multiplicando $t2 por 4 (tamanho de um elemento)
  add $t7, $a0, $t7 # $t7 cont�m o endere�o de A[i]
  lw $t6, 0($t7)     # Carrega A[i]

  sll $t5, $t1, 2   # Multiplicando $t1 por 4 (tamanho de um elemento)
  add $t5, $a0, $t5 # $t5 cont�m o endere�o de A[indicemenor]
  lw $t4, 0($t5)     # Carrega A[indicemenor]

  # Troca os valores entre $t6 e $t4
  sw $t4, 0($t7)  # A[i] = A[indicemenor]
  sw $t6, 0($t5)  # A[indicemenor] = A[i]

  # Incrementa o �ndice atual ($t2)
  addi $t2, $t2, 1

  # Verifica se o �ndice atual ($t2) � menor que o tamanho do array ($a1)
  blt $t2, $a1, for_i_loop  # Se $t2 < $a1, continue o loop externo

  # Fim da fun��o de ordena��o por sele��o
  jr $ra

exit:
