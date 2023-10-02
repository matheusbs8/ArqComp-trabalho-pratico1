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