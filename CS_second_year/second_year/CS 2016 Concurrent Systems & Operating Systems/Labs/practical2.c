#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>


#define NUM_THREADS 4
#define BUFFER_LENGTH 1000
#define QUEUE_LENGTH 50

pthread_mutex_t stringMutex;
pthread_cond_t stringCount;

pthread_mutex_t printMutex;
pthread_cond_t printCount;

typedef struct Queue
{
	int head;
	int tail;
	int itemCount;
	char* queue[QUEUE_LENGTH];
}Queue;


Queue stringQueue;
Queue printQueue;


void* consumerThread(void* id)
{	
	printf("Consumer thread %d created\n", id);
	while(1)
	{
		pthread_mutex_lock(&stringMutex);
		pthread_cond_wait(&stringCount, &stringMutex);
		if(stringQueue.itemCount > 0)
		{	

			pthread_mutex_lock(&printMutex);
			printQueue.tail++;
			printQueue.itemCount++;
			
			char string[BUFFER_LENGTH];	
			sprintf(string, "%d. ", id);
			strcat(string, stringQueue.queue[stringQueue.head]); 
			printQueue.queue[printQueue.tail] = string;
			stringQueue.itemCount--;
			stringQueue.head++;
			pthread_cond_signal(&printCount);
			pthread_mutex_unlock(&printMutex);
		}
		pthread_mutex_unlock(&stringMutex);
	}
}

void* printingThread(void* id)
{
	printf("Printing thread %d created\n", id);
	while(1)
	{
		pthread_mutex_lock(&printMutex);
		pthread_cond_wait(&printCount, &printMutex);
		if(printQueue.itemCount > 0)
		{
			printf("%s\n",printQueue.queue[printQueue.head]);
			printQueue.head++;
			printQueue.itemCount--;
			pthread_mutex_unlock(&printMutex);
		}
	}
}




int main(int argc, char** argv)
{
	stringQueue.head = 0;
	stringQueue.tail = -1;
	stringQueue.itemCount = 0;
	
	printQueue.head = 0;
	printQueue.tail = -1;
	printQueue.itemCount = 0;

	pthread_t threads[NUM_THREADS];
	pthread_mutex_init(&stringMutex, NULL);
	pthread_mutex_init(&printMutex, NULL);
	pthread_cond_init(&stringCount, NULL);
	pthread_cond_init(&printCount, NULL);

	int rc;
	bool loop = true;
	size_t i;
	for(i = 0; i<NUM_THREADS; i++)
	{
		printf("Creating %s thread %zu\n",(i>2)?"printing":"consumer", i);
		rc = pthread_create(&threads[i], NULL, (i>2)?printingThread:consumerThread, (void *)i);
		if(rc!=0)
		{
			printf("Error creating thread, return code: %d\n", rc);
			return -1;
		}
	}
	char s[BUFFER_LENGTH];
	printf("Type in message, type in 'END' to quit.\n");
	while(loop)
	{	
		while(stringQueue.itemCount < QUEUE_LENGTH)
		{	
			fgets(s, BUFFER_LENGTH, stdin);
			//Remove new line character from string
			int len = strlen(s);
			if( len>0 && s[len-1]=='\n')
			{
				s[len-1]='\0';
			}	
			if(strcmp(s, "END") == 0)
			{
				loop = false;
			}		
			else if(len>0)
			{
				stringQueue.tail++;
				stringQueue.queue[stringQueue.tail] = s;
				stringQueue.itemCount++;
				pthread_cond_signal(&stringCount);			
			}
		}
		if(stringQueue.itemCount >= QUEUE_LENGTH)
		{
			printf("Queue is full\n");
			loop = false;
		}
	}
	printf("Goodbye\n");
	pthread_mutex_destroy(&stringMutex);
	pthread_mutex_destroy(&printMutex);
	pthread_cond_destroy(&stringCount);
	pthread_cond_destroy(&printCount);
	return 0;
}
