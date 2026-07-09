#include <windows.h>
#include <stdio.h>

int main() {
	char buffer[128] = {0};
	DWORD bytesRead = 0;


	if (ReadFile(
	            GetStdHandle(STD_INPUT_HANDLE),
	            buffer, sizeof(buffer) - 1,
	            &bytesRead, NULL)
	        && bytesRead > 0) {
		buffer[bytesRead] = '\0';
		printf("Child收到消息：%s\n", buffer);
	}

	return 0;
}