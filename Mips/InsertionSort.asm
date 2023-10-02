.data
A: .word 3, 2, 7, 8, 1, 9, 10, 4, 7  # Array A com espaço para 9 inteiros
tamanho: .word 9            # Variável tamanho para armazenar o tamanho do array

.text
.globl main

main:
    # Carregando o tamanho do array na variável $t0
    lw $t0, tamanho

    # Inicializando o índice i com 1
    li $t1, 1
    
for_i_loop:
    # Se i >= tamanho, sair do loop
    bge $t1, $t0, end

    # Carregando o endereço de A[i] (eleito)
    la $t5, A
    sll $t7, $t1, 2   # Multiplicando $t1 por 4 (tamanho de um elemento)
    add $t5, $t5, $t7 # $t5 contém o endereço de A[i]

    # Carregando A[i] (eleito) na variável $t2
    lw $t2, ($t5)

    # Inicializando j com i-1
    sub $t3, $t1, 1
    
while_loop:
    # Se j < 0 ou A[j] <= eleito, sair do loop
    bltz $t3, end_while

    # Carregando o endereço de A[j]
    la $t6, A
    sll $t8, $t3, 2   # Multiplicando $t3 por 4 (tamanho de um elemento)
    add $t6, $t6, $t8 # $t6 contém o endereço de A[j]

    # Carregando A[j] na variável $t4
    lw $t4, ($t6)

    # Comparando eleito com A[j]
    bge $t2, $t4, end_while

    # A[j+1] = A[j]
    sw $t4, ($t5)

    # Decrementando j
    sub $t3, $t3, 1

    # Atualizando o endereço de A[i] (eleito) para A[j]
    sub $t5, $t5, 4

    # Voltando para o início do loop
    j while_loop

end_while:
    # A[j+1] = eleito
    sw $t2, ($t5)

    # Incrementando i
    addi $t1, $t1, 1

    # Voltando para o início do loop externo
    j for_i_loop

end:
    # Fim do programa
    li $v0, 10
    syscall