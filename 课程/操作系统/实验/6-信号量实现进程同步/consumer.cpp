#include <windows.h>
#include <stdio.h>

#define BUFFER_SIZE    5
#define PRODUCE_COUNT  10

const char *SHM_NAME   = "ProdconsShm";
const char *SEM_EMPTY  = "SemEmpty";
const char *SEM_FULL   = "SemFull";
const char *MUTEX_NAME = "MutexBuffer";

struct SharedBuffer {
	int buffer[BUFFER_SIZE];
	int in, out;
};

int main() {

	HANDLE hMap = OpenFileMappingA(
	                  FILE_MAP_ALL_ACCESS,
	                  FALSE,
	                  SHM_NAME
	              );

	if (!hMap) {
		printf("OpenFileMapping Failed %u\n", GetLastError());
		return 1;
	}
	SharedBuffer *shm = (SharedBuffer *)MapViewOfFile(
	                        hMap, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(SharedBuffer)
	                    );

	HANDLE semEmpty = OpenSemaphoreA (SEMAPHORE_ALL_ACCESS, FALSE, SEM_EMPTY);
	HANDLE semFull  = OpenSemaphoreA(SEMAPHORE_ALL_ACCESS, FALSE, SEM_FULL);
	HANDLE hMutex   = OpenMutexA (MUTEX_ALL_ACCESS, FALSE, MUTEX_NAME);
	if (!semEmpty || !semFull || !hMutex) {
		printf("OpenSemaphore/Mutex Failed %u\n", GetLastError());
		return 1;
	}

	for (int i = 1; i <= PRODUCE_COUNT; ++i) {
		printf("consumer: waiting for full slot...\n");
		WaitForSingleObject (semFull, INFINITE);
		printf("consumer: got full slot\n");


		WaitForSingleObject (hMutex, INFINITE);
		int item = shm->buffer[shm->out];
		printf("consumer got %d from [%d]\n", item, shm->out);
		shm->out = (shm->out + 1) % BUFFER_SIZE;
		ReleaseMutex (hMutex);

		ReleaseSemaphore (semEmpty, 1, NULL);
		printf("consumer: signaled empty slot\n");

		Sleep(150);
	}


	CloseHandle (semEmpty);
	CloseHandle (semFull);
	CloseHandle (hMutex);

	UnmapViewOfFile (shm);
	CloseHandle (hMap);
	return 0;
}