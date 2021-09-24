#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

// This is as of March 7, 2018

#define NUM_CONSUMER_THREADS 3

struct mc {
  char *str;
  int new;
};

struct cp {
  char *str;
  int index;
  int new;
};

struct mc mtoc;
struct cp ctop;

pthread_mutex_t mcm = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t cpm = PTHREAD_MUTEX_INITIALIZER;

pthread_cond_t mccv = PTHREAD_COND_INITIALIZER;
pthread_cond_t cpcv = PTHREAD_COND_INITIALIZER;

void *consumerThreadFunction(void *stuff) {
  int *p = (int *)stuff;
  int index = *p;
  printf("Consumer thread index is %d.\n", index);
  while (1) {
    pthread_mutex_lock(&mcm);
    while (mtoc.new == 0)
      pthread_cond_wait(&mccv, &mcm);
    char *s = mtoc.str;
    mtoc.new = 0;
    pthread_mutex_unlock(&mcm);
    printf("Consumer %d has the string \"%s\".\n", index, s);
  }
  pthread_exit(NULL);
}

void *printerThreadFunction(void *stuff) {
  printf("Printer thread is ready.\n");
  pthread_exit(NULL);
}

int main(int argc, const char *argv[]) {

  mtoc.new = 0;
  ctop.new = 0;

  pthread_t threads[NUM_CONSUMER_THREADS];
  int indexes[NUM_CONSUMER_THREADS];
  int rc, t;
  for (t = 0; t < NUM_CONSUMER_THREADS; t++) {
    printf("Creating thread %d\n", t);
    indexes[t] = t;
    rc = pthread_create(&threads[t], NULL, consumerThreadFunction,
                        (void *)&indexes[t]);
    if (rc) {
      printf("ERROR return code from pthread_create() of consumer thread: %d\n",
             rc);
      exit(-1);
    }
  }

  pthread_t printerThread;
  rc = pthread_create(&printerThread, NULL, printerThreadFunction, NULL);
  if (rc) {
    printf(
        "ERROR return code from pthread_create() of the printer thread: %d\n",
        rc);
    exit(-1);
  }

  while (1) {
    size_t n = 0;
    char *lineptr = NULL;
    ssize_t len = getline(&lineptr, &n, stdin);

    printf("A string of %ld characters was read: \"%s\".\n", len, lineptr);

    pthread_mutex_lock(&mcm);
    mtoc.str = lineptr;
    mtoc.new = 1;
    pthread_cond_signal(&mccv);
    pthread_mutex_unlock(&mcm);
  }

  // wait for threads to exit
  for (t = 0; t < NUM_CONSUMER_THREADS; t++) {
    pthread_join(threads[t], NULL);
  }
  return 0;
}