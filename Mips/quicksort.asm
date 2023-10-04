# Dados do array
.data
A:  .word 3, 6, 1, 4, 9, 10, 2, 5
tamanho: .word 8

.text
# Inicializa $a0 com o endereço de A
la $a0, A

# Inicializa $a1 com o índice de início (0)
li $a1, 0

# Inicializa $a2 com o índice de fim (tamanho - 1)
lw $t8, tamanho
subi $t8, $t8, 1
move $a2, $t8

# Chama quickSort
jal quickSort
j exit

# Função quickSort
quickSort:
    # Argumentos: $a0 = endereço do array A, $a1 = índice de início, $a2 = índice de fim
    move $s0, $a1       # $s0 = início
    move $s2, $a2       # $s2 = fim
    add $s1, $s2, $s0   # $s1 = $s2 - $s0

    # Calcula o índice do pivo
    add $s1, $s0, $s2   # $s1 = $s0 + $s2 (i + j)
    srl $s1, $s1, 1     # $s1 = $s1 / 2 (divisão lógica por 2)
    
    la $t3, A # Começa a ler $t3 = A[pivo]
    sll $t6, $s1, 2
    add $t3, $t3, $t6
    lw $t3, ($t3) # Termina de ler $t3 = A[pivo]

    jal partition_loop
    jr $ra

partition_loop:
    # Enquanto (i <= j)
    bgt $s0, $s2, end_partition

    # Enquanto (A[i] < pivo)
    la $t4, A # Começa a ler $t4 = A[i]
    sll $t6, $s0, 2
    add $t4, $t4, $t6
    lw $t4, ($t4) # Termina de ler $t4 = A[i]
    
    bge $t4, $t3, skip_increment_i # A[i] < pivo
    
increment_i:
    addi $s0, $s0, 1
    la $t4, A # Começa a ler $t4 = A[i]
    sll $t6, $s0, 2
    add $t4, $t4, $t6
    lw $t4, ($t4) # Termina de ler $t4 = A[i]   
    
    blt $t4, $t3, increment_i

skip_increment_i:
    # Enquanto (A[j] > pivo)
    la $t4, A # Começa a ler $t4 = A[j]
    sll $t6, $s2, 2
    add $t4, $t4, $t6
    lw $t4, ($t4) # Termina de ler $t4 = A[j]
    
    ble $t4, $t3, skip_decrement_j  # decrement_j A[j] > pivo
    
decrement_j:
    subi $s2, $s2, 1
    la $t4, A # Começa a ler $t4 = A[j]
    sll $t6, $s2, 2
    add $t4, $t4, $t6
    lw $t4, ($t4) # Termina de ler $t4 = A[j]   
    
    bgt $t4, $t3, decrement_j
    
skip_decrement_j:
    # Troca A[i] e A[j]
    bgt $s0, $s2, skip_swap
    
    # Carrega o valor de A[i] em $t8
    la $t6, A 
    sll $t8, $s0, 2
    add $t6, $t6, $t8
    lw $t8, ($t6)

    # Carrega o valor de A[j] em $t9
    la $t7, A
    sll $t9, $s2, 2
    add $t7, $t7, $t9
    lw $t9, ($t7)

    # Troca os valores entre $t8 e $t9
    sw $t9, ($t6)  # A[i] = $t9
    sw $t8, ($t7)  # A[j] = $t8
    
    addi $s0, $s0, 1   # i++
    subi $s2, $s2, 1    # j--
    
skip_swap:
    j partition_loop

end_partition:
    # Chamadas recursivas
    bge $a1, $s2, skip_first_recursive_call
    move $a2, $s2       # Argumento para a primeira chamada recursiva
    jal quickSort
    nop
    move $s2, $a2       # Recupera $s2

skip_first_recursive_call:
    bge $s0, $a2, skip_second_recursive_call
    move $a1, $s0       # Argumento para a segunda chamada recursiva
    jal quickSort
    nop

skip_second_recursive_call:
    # Restaura os registradores
    # lw $ra, 0($sp)
    # lw $s0, 4($sp)
    # lw $s1, 8($sp)
    # lw $s2, 12($sp)
    # add $sp, $sp, 16

    jr $ra               # Retorno da função

exit:
    
