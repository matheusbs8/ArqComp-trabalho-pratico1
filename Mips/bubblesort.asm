.data
A:  .word 3, 5, 1, 4, 10, 9, 15, 16, 2
tamanho: .word 9

.text
main:
    # Inicializa $a0 com o endereço de A
    la $a0, A

    # Inicializa $a1 com o tamanho do array (n)
    lw $a1, tamanho

    # Chama a função bubbleSort
    jal bubbleSort
    
    # Termina o programa
    j exit

# Função bubbleSort
# Argumentos: $a0 = endereço de A, $a1 = tamanho (n)
bubbleSort:
    subi $sp, $sp, 8   # Aloca espaço na pilha para salvar $ra e $t0
    sw $ra, 4($sp)     # Salva $ra na pilha
    sw $t0, 0($sp)     # Salva $t0 na pilha

    li $t8, 1          # Inicializa $t8 com 1 (true)

outer_loop:
    li $t9, 0          # Inicializa $t9 com 0 (false)

    # Loop interno para uma passagem
    move $t0, $a0      # $t0 = endereço de A
    addi $t1, $a1, -1  # $t1 = n - 1 (último índice)
    
    inner_loop:
        lw $t2, 0($t0)  # Carrega A[i] em $t2
        lw $t3, 4($t0)  # Carrega A[i+1] em $t3

        # Comparação A[i] > A[i+1]
        bgt $t2, $t3, swap_elements

        # Se A[i] <= A[i+1], continue
        j continue_comparison

        # Troca A[i] e A[i+1]
        swap_elements:
    	   lw $t5, 0($t0)

    	   # Carrega o valor de A[j] em $t6
    	   lw $t6, 4($t0)

    	   # Troca os valores entre $t5 e $t6
    	   sw $t6, 0($t0)  # A[i] = $t9
    	   sw $t5, 4($t0)  # A[j] = $t8
           li $t9, 1  # Indica que houve uma troca

        continue_comparison:
            addi $t0, $t0, 4  # Avança para A[i+1]
            addi $t1, $t1, -1  # Decrementa o contador

        # Verifica se o loop interno deve continuar
        bgtz $t1, inner_loop

    # Verifica se houve alguma troca nesta passagem
    beqz $t9, end_sort

    # Se houve troca, continue para a próxima passagem
    li $t9, 0
    j outer_loop

end_sort:
    lw $ra, 4($sp)     # Restaura $ra da pilha
    lw $t0, 0($sp)     # Restaura $t0 da pilha
    addi $sp, $sp, 8   # Libera espaço na pilha
    jr $ra
    
exit:

