#include <stdio.h>
int row[50], col[50], val[50];
int main() {
	int m, n, cnt = 0, i, j, tmp;
	scanf("%d%d", &n, &m);
	for (i = 1; i <= n; i++) {
		for (j = 1; j <= m; j++) {
			scanf("%d", &tmp);
			if (tmp) {
				row[cnt] = i;
				col[cnt] = j;
				val[cnt] = tmp;
				cnt++;
			}
		}
	}
	while (cnt > 0) {
		cnt--;
		printf("%d %d %d\n", row[cnt], col[cnt], val[cnt]);
	}
	return 0;
}
