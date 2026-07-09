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

	HANDLE hMap = CreateFileMappingA(
	                  INVALID_HANDLE_VALUE, NULL,
	                  PAGE_READWRITE,
	                  0, sizeof (SharedBuffer),
	                  SHM_NAME
	              );

	if (!hMap) {
		printf("CreateFileMapping Failed %u\n", GetLastError());
		return 1;
	}
	SharedBuffer *shm = (SharedBuffer *)MapViewOfFile(
	                        hMap, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(SharedBuffer)
	                    );
	shm->in = shm->out = 0;

	HANDLE semEmpty = CreateSemaphoreA (NULL, BUFFER_SIZE, BUFFER_SIZE, SEM_EMPTY);
	HANDLE semFull  = CreateSemaphoreA(NULL, 0, BUFFER_SIZE, SEM_FULL);
	HANDLE hMutex   = CreateMutexA (NULL, FALSE, MUTEX_NAME);
	if (!semEmpty || !semFull || !hMutex) {
		printf("CreateSemaphore/Mutex Failed %u\n", GetLastError());
		return 1;
	}

	STARTUPINFOA si = {sizeof(si)};
	PROCESS_INFORMATION pi = {0};
	if (!CreateProcessA(
	            NULL,
	            (LPSTR) "Consumer.exe",
	            NULL, NULL,
	            FALSE,
	            0, NULL, NULL,
	            &si, &pi)) {
		printf ("CreateProcess Failed %u\n", GetLastError());
		return 1;
	}


	for (int item = 1; item <= PRODUCE_COUNT; ++item) {
		printf("producer: waiting for empty slot...\n");
		WaitForSingleObject (semEmpty, INFINITE);
		printf("producer: got empty slot\n");


		WaitForSingleObject (hMutex, INFINITE);
		shm->buffer[shm->in] = item;
		printf("producer put %d at [%d]\n", item, shm->in);
		shm->in = (shm->in + 1) % BUFFER_SIZE;
		ReleaseMutex (hMutex);

		ReleaseSemaphore (semFull, 1, NULL);
		printf("Producer: signaled full slot\n");

		Sleep(100);
	}

	WaitForSingleObject (pi.hProcess, INFINITE);

	CloseHandle (pi.hProcess);
	CloseHandle (pi.hThread);
	CloseHandle (semEmpty);
	CloseHandle (semFull);
	CloseHandle (hMutex);

	UnmapViewOfFile (shm);
	CloseHandle (hMap);
	return 0;

}