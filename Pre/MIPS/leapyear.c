#include <stdio.h>
int main() {
	int n, flag = 0;
	scanf("%d", &n);
	if (n % 100) {
		if (n % 4 == 0) flag = 1;
	}
	else {
		if (n % 400 == 0) flag = 1;
	}
	printf("%d\n", flag);
	return 0;
}
