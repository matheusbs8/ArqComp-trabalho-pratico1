#include <stdio.h>
#include <stdbool.h>

void bubbleSort(int A[], int tamanho)
{
    bool trocado;

    do
    {
        trocado = false;

        for (int i = 0; i < tamanho - 1; i++)
        {
            if (A[i] > A[i + 1])
            {
                int temp = A[i];
                A[i] = A[i+1];
                A[i+1] = temp;

                trocado = true;
            }
        }

    } while (trocado);
}

int main()
{
    int A[] = {3, 5, 1, 4, 10, 9, 15, 16, 2};
    int tamanho = sizeof(A) / sizeof(A[0]);

    printf("Array original:\n");
    for (int i = 0; i < tamanho; i++)
    {
        printf("%d ", A[i]);
    }
    printf("\n");

    bubbleSort(A, tamanho);

    printf("Array ordenado:\n");
    for (int i = 0; i < tamanho; i++)
    {
        printf("%d ", A[i]);
    }
    printf("\n");

    return 0;
}