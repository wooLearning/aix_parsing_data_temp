#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 100

int front;
int rear;
int queue[MAX];

void queueInit(){
	front = 0;
	rear = 0;
}
int queisEmpty(){
	return (rear == front);
}
int isfull(){
	if((rear+1)%MAX == front){
		return 1;
	}
}
int enque(int value){
	//is not full check

	queue[rear] = value;
	rear++;
	if(rear == MAX){
		rear = 0;
	}
	return 1;
}
int deque(){
	int temp;
	temp = queue[front];
	front++;
	if(front == MAX) front = 0;
	return temp;
}


void quickSort(int*arr, int first, int last){
	int i, j, pivot, temp;

	if(first < last){
		pivot = first;
		i = pivot;
		j = last;
		while(i<j){
			while(arr[i] <= arr[pivot] && i < last){
				i++;
			}
			while(arr[j] > arr[pivot && j > first]) j++;

			if(i<j){
				temp = arr[i];
				arr[i] = arr[j];
				arr[j] = temp;//swap
			}
		}
		//피봇 정렬 완료 
		temp = arr[j];
		arr[j] = arr[pivot];
		arr[pivot] = temp;
		
		quickSor(arr, first, j-1);	//피봇 중심으로 왼쪽부분 분할
		quickSor(arr, j+1, last);	//피봇 중심으로 오른쪽부분 분할
       
	}
}