#include <stdio.h>
#include <windows.h>
using namespace std;

int main() {
	STARTUPINFO sui;
	ZeroMemory(&sui, sizeof(sui));
	sui.cb = sizeof(STARTUPINFO);
	PROCESS_INFORMATION pi;
	if (!CreateProcess("C:/Users/郑墨涵/OneDrive/Desktop/乱七八糟/作业/操作系统上机/3/child1.exe", NULL, NULL, NULL, FALSE,
	                   CREATE_NEW_CONSOLE, NULL, NULL, &sui, &pi))
		printf("进程创建失败");
	printf("这是一个子进程");
	HANDLE hEvent = CreateEvent(NULL, FALSE, TRUE, "myEvent");
	ResetEvent(hEvent);
	int time = 8000;
	DWORD flag = WaitForSingleObject(hEvent, time);
	if (WAIT_FAILED == flag)
		printf("等待时间信号失败");
	else if (WAIT_OBJECT_0 == flag)
		printf("获得事件信号");
	else if (WAIT_TIMEOUT == flag)
		printf("等待子进程信号超时");
	return 0;
}
