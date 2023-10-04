#include <stdio.h>

void troca(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

void quickSort(int A[], int inicio, int fim)
{
    int i = inicio;
    int j = fim;
    int pivo = A[(i + j) / 2];

    while (i <= j)
    {
        while (A[i] < pivo)
            i++;

        while (A[j] > pivo)
            j--;
        
        if (i <= j)
        {
            troca(&A[i], &A[j]);
            i++;
            j--;
        }
    }

    if (inicio < j)
        quickSort(A, inicio, j);

    if (i < fim)
        quickSort(A, i, fim);
}

int main()
{
    int A[] = {3, 6, 1, 4, 9};
    int tamanho = sizeof(A) / sizeof(A[0]);

    printf("Array original:\n");
    for (int i = 0; i < tamanho; i++)
    {
        printf("%d ", A[i]);
    }
    printf("\n");

    quickSort(A, 0, tamanho - 1);

    printf("Array ordenado:\n");
    for (int i = 0; i < tamanho; i++)
    {
        printf("%d ", A[i]);
    }
    printf("\n");

    return 0;
}