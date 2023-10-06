.data
A: .word 3, 2, 7, 8, 1, 9, 10, 4, 7
tamanho: .word 9

.text
main:
    # Inicializa $a0 com o endereço de A
    la $a0, A

    # Inicializa $a1 com o tamanho do vetor
    lw $a1, tamanho

    # Chama insertionSort
    jal InsertionSort

    # Saída do programa
    j exit


# Função InsertionSort
InsertionSort:
    # Argumentos: $a0 = endereço do array A, $a1 = tamanho do array
    move $s0, $a0       # endereço do array A
    move $s1, $a1       # tamanho do array
 

    # Inicializando o índice i com 1
    li $t1, 1

for_i_loop:
    # Se i >= tamanho, sair do loop
    bge $t1, $a1, end

    # Carregando o endereço de A[i] (eleito)
    sll $t6, $t1, 2   # Multiplicando $t1 por 4 (tamanho de um elemento)
    add $t5, $s0, $t6 # $t5 contém o endereço de A[i]

    # Carregando A[i] (eleito) na variável $t2
    lw $t2, ($t5)

    # Inicializando j com i-1
    sub $t3, $t1, 1

while_loop:
    # Se j < 0 ou A[j] <= eleito, sair do loop
    slt $t6, $t3, $zero   # $t8 = 1 se $t3 < 0, senão $t8 = 0

    # Branch condicional se $t8 for igual a 0 (j >= 0)
    beq $t6, $zero, se_j_maior_ou_igual_0

    # Código a ser executado se j < 0
    j end_while

    # Label para o caso em que j >= 0
se_j_maior_ou_igual_0:
    
    # Carregando o endereço de A[j]
    sll $t7, $t3, 2   # Multiplicando $t3 por 4 (tamanho de um elemento)
    add $t6, $s0, $t7 # $t6 contém o endereço de A[j]

    # Carregando A[j] na variável $t4
    lw $t4, ($t6)

    # Comparando eleito com A[j]
    bge $t2, $t4, end_while

    # A[j+1] = A[j]
    sw $t4, 0($t5)

    # Decrementando j
    sub $t3, $t3, 1

    # Atualizando o endereço de A[i] (eleito) para A[j]
    sub $t5, $t5, 4

    # Voltando para o início do loop
    j while_loop

end_while:
    # A[j+1] = eleito
    sw $t2, 0($t5)

    # Incrementando i
    addi $t1, $t1, 1

    # Voltando para o início do loop externo
    j for_i_loop

end:
    # saindo da função
    
    jr $ra
exit: