#include <windows.h>
#include <stdio.h>
#include <string.h>

int main() {
	SECURITY_ATTRIBUTES sa = {sizeof(SECURITY_ATTRIBUTES), NULL, TRUE};

	HANDLE hRead = NULL, hWrite = NULL;
	if (!CreatePipe(&hRead, &hWrite, &sa, 0)) {
		printf("CreatePipe Ê§°Ü£¬´íÎóÂë£º%u\n", GetLastError());
		return 1;
	}

	SetHandleInformation(hWrite, HANDLE_FLAG_INHERIT, 0);

	STARTUPINFOA si = {0};
	si.cb          = sizeof(si);
	si.dwFlags     = STARTF_USESTDHANDLES;
	si.hStdInput   = hRead;
	si.hStdOutput  = GetStdHandle(STD_OUTPUT_HANDLE);
	si.hStdError   = GetStdHandle(STD_ERROR_HANDLE);

	PROCESS_INFORMATION pi = {0};
	char cmdLine[] = "Child.exe";

	if (!CreateProcessA(
	            NULL,
	            cmdLine,
	            NULL, NULL,
	            TRUE,
	            0,
	            NULL, NULL,
	            &si, &pi)) {
		printf("CreateProcess Ê§°Ü£¬´íÎóÂë£º%u\n", GetLastError());
		return 1;
	}


	CloseHandle(hRead);


	const char *message = "Hello from Parent!";
	DWORD written = 0;
	WriteFile(hWrite, message, (DWORD)strlen(message), &written, NULL);


	CloseHandle(hWrite);


	WaitForSingleObject(pi.hProcess, INFINITE);
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);

	return 0;

}