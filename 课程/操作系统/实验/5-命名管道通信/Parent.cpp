#include <windows.h>
#include <stdio.h>
#include <string.h>

int main() {

	const char *PIPE_NAME = "\\\\.\\pipe\\MyPipe";


	HANDLE hPipe = CreateNamedPipeA(
	                   PIPE_NAME,
	                   PIPE_ACCESS_INBOUND,
	                   PIPE_TYPE_BYTE | PIPE_WAIT,
	                   1,
	                   0, 0,
	                   0,
	                   NULL);


	if (hPipe == INVALID_HANDLE_VALUE) {
		printf("CreateNamedPipe道失败, Error= %u\n", GetLastError());
		return 1;
	}

	STARTUPINFOA si = {sizeof(si)};
	PROCESS_INFORMATION pi = {0};

	if (!CreateProcessA(
	            NULL,
	            (LPSTR)"Child2.exe",
	            NULL, NULL,
	            FALSE,
	            0, NULL, NULL,
	            &si, &pi)) {
		printf("CreateProcess 失败，Error=%u\n", GetLastError());
		CloseHandle(hPipe);
		return 1;
	}



	BOOL connected = ConnectNamedPipe(hPipe, NULL) 
	            || GetLastError() == ERROR_PIPE_CONNECTED;
	if (!connected) {
		printf("CreateNamedPipe 失败，Error=%u\n", GetLastError());
		CloseHandle(hPipe);
		return 1;
	}


	char buffer[128] = {0};
	DWORD bytesRead = 0;


	if (ReadFile(
	            hPipe,
	            buffer, sizeof(buffer) - 1,
	            &bytesRead, NULL)
	        && bytesRead > 0) {
		buffer[bytesRead] = '\0';
		printf("Parent从命名管道收到：%s\n", buffer);
	} else {
		printf("ReadFile 失败，Error=%u\n", GetLastError());
	}


	CloseHandle(hPipe);
	WaitForSingleObject(pi.hProcess, INFINITE);
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);


	return 0;

}
