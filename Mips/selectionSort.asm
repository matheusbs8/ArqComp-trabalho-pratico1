.data
A: .word 3, 2, 7, 8, 1, 9, 10, 4, 7, 99  # Array A com elementos
tamanho: .word 10  # Variável tamanho para armazenar o tamanho do array

.text
.globl main

main:
  # Carregando o tamanho do array na variável $a1
  lw $a1, tamanho
  la $a0, A

  # Chama a função de ordenação por seleção
  jal selection_sort

  # Saída do programa
  j exit

selection_sort:
  # Inicializando o índice do menor elemento (t1) com 0
  li $t1, 0
  li $t2, 0  # $t2 é o índice i

for_i_loop:
  # Inicializa o índice do menor elemento com o índice atual
  move $t1, $t2

  # Inicia o índice j a partir de i+1
  add $t8, $t2, 1

for_j_loop:
  # Carregando o endereço de A[j] (eleito)
  sll $t4, $t8, 2   # Multiplicando $t8 por 4 (tamanho de um elemento)
  add $t4, $a0, $t4  # $t4 contém o endereço de A[j]
  # Carregando A[j] (eleito) na variável $t5
  lw $t5, 0($t4)  # $t5 contém A[j]

  # Carregando o endereço de A[indiceMenor] (eleito)
  sll $t6, $t1, 2   # Multiplicando $t1 por 4 (tamanho de um elemento)
  add $t6, $a0, $t6  # $t6 contém o endereço de A[indiceMenor]
  # Carregando A[indiceMenor] (eleito) na variável $t7
  lw $t7, 0($t6)  # $t7 contém A[indiceMenor]

  # Compara os elementos
  bge $t5, $t7, skip_swap  # Se A[j] >= A[indiceMenor], pule para skip_swap

  # Se A[j] < A[indiceMenor], atualiza o índice do menor elemento
  move $t1, $t8

skip_swap:
  # Incrementa $t8 para comparar com o próximo elemento
  addi $t8, $t8, 1

  # Verifica se o índice atual ($t8) é menor que o tamanho do array ($a1)
  blt $t8, $a1, for_j_loop  # Se j < tam, continue o loop interno

  # Swap: Troca A[i] com o menor elemento A[indiceMenor]
  sll $t7, $t2, 2   # Multiplicando $t2 por 4 (tamanho de um elemento)
  add $t7, $a0, $t7 # $t7 contém o endereço de A[i]
  lw $t6, 0($t7)     # Carrega A[i]

  sll $t5, $t1, 2   # Multiplicando $t1 por 4 (tamanho de um elemento)
  add $t5, $a0, $t5 # $t5 contém o endereço de A[indicemenor]
  lw $t4, 0($t5)     # Carrega A[indicemenor]

  # Troca os valores entre $t6 e $t4
  sw $t4, 0($t7)  # A[i] = A[indicemenor]
  sw $t6, 0($t5)  # A[indicemenor] = A[i]

  # Incrementa o índice atual ($t2)
  addi $t2, $t2, 1

  # Verifica se o índice atual ($t2) é menor que o tamanho do array ($a1)
  blt $t2, $a1, for_i_loop  # Se $t2 < $a1, continue o loop externo

  # Fim da função de ordenação por seleção
  jr $ra

exit:
