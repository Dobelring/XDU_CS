#include <windows.h>
#include <stdio.h>
#include <string.h>

int main() {

	const char *PIPE_NAME = "\\\\.\\pipe\\MyPipe";


	HANDLE hPipe = CreateFileA(
	                   PIPE_NAME,
	                   GENERIC_WRITE,
	                   0,
	                   NULL,
	                   OPEN_EXISTING,
	                   0, NULL);


	if (hPipe == INVALID_HANDLE_VALUE) {
		printf("CreateFile 打开管道失败, Error= %u\n", GetLastError());
		return 1;
	}
	const char *message = "Hello from Child via named pipe";
	DWORD written = 0;
	if (!WriteFile(hPipe, message, (DWORD)strlen(message), &written, NULL)) {
		printf("WriteFile 失败, Error=%u\n", GetLastError());
	}

	CloseHandle(hPipe);
	return 0;

}