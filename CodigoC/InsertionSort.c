void insertionSort(int A[], int tamanho) {
    int i, j, eleito;

    for (i = 1; i < tamanho; i++) {
        eleito = A[i];
        j = i - 1;

        while (j >= 0 && eleito < A[j]) {
            A[j + 1] = A[j];
            j = j - 1;
        }

        A[j + 1] = eleito;
    }
}

int main() {
    // Inicializa um vetor com valores específicos
    int vetor[] = {3, 2, 7, 8, 1, 9, 10, 4, 7};
    int tamanho = 9;

    insertionSort(vetor, tamanho);
    return 0;
}