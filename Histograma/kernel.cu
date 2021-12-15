#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "math.h"
/*8 bits --> 255 valores*/
#define n 16
#define iterCPU 100

void Calc_Hist(unsigned int* Hist, unsigned int* Image) {
	/*Hacemos el histograma*/
	for (int i = 0; i < n * n; i++) {
		Hist[Image[i]] += 1;
	}

}

int main() {
	unsigned int *Image,*Hist;
	Image = (unsigned int*)malloc(n * n * sizeof(unsigned int));
	Hist = (unsigned int*)malloc( 256* sizeof(unsigned int));
	/*Inicializamos variables*/
	for (int i = 0; i < 256; i++) {
		Hist[i] = 0;//Reemplazo de calloc
	}
	/*Inicializamos la imagen con numeros aleatorios*/
	srand(time(NULL));
	for (int i=0; i < n * n; i++) {
		Image[i] = (unsigned int)(rand()%256);
	}
	/*Medimos tiempo*/
	clock_t startCPU;
	clock_t finishCPU;
	startCPU = clock();
	for (int i = 0; i < iterCPU; i++) {
		Calc_Hist(Hist, Image);
	}
	finishCPU = clock();
	printf("Numero de iteraciones:%d\n", iterCPU);
	printf("CPU serial time: %fms\n", (double)(finishCPU - startCPU) / iterCPU);/// CLK_TCK);

	FILE* archivo;
	archivo = fopen("Histograma.csv", "w+");
	fprintf(archivo, "valores\n");
	for (unsigned int i = 0; i < 256; i++) {
		fprintf(archivo, "%d\n", Hist[i]);
	}
	fclose(archivo);
	printf("Se creo el archivo de histograma");
}