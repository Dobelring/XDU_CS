#include <stdio.h>
#include <windows.h>
using namespace std;

int main() {
	HANDLE hEvent = OpenEvent(EVENT_ALL_ACCESS, TRUE, "myEvent");
	Sleep(1000);
	char ch;
	printf("Signal the event to Parent[y/n]");
	scanf("%c", &ch);
	if (ch == 'y')
		SetEvent(hEvent);
	Sleep(1000);
	system("pause");
	return 0;
}