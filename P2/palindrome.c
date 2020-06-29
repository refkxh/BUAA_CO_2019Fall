#include <stdio.h>
char s[20];
int main() {
	int n, i;
	scanf("%d", &n);
	for (i = 0; i < n; i++) {
		s[i] = getchar();
		//scanf("%c", &s[i]);
		//if (s[i] == '\n') i--;
	}
	for (i = 0; i < (n >> 1); i++) {
		if (s[i] != s[n - i - 1]) {
			putchar('0');
			return 0;
		}
	}
	putchar('1');
	return 0;
}
