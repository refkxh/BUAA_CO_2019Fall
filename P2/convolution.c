#include <stdio.h>
int m[16][16], core[16][16];
int main() {
	int m1, n1, m2, n2, i, j, k, l, ans;
	scanf("%d%d%d%d", &m1, &n1, &m2, &n2);
	for (i = 0; i < m1; i++) {
		for (j = 0; j < n1; j++) {
			scanf("%d", &m[i][j]);
		}
	}
	for (i = 0; i < m2; i++) {
		for (j = 0; j < n2; j++) {
			scanf("%d", &core[i][j]);
		}
	}
	for (i = 0; i < m1 - m2 + 1; i++) {
		for (j = 0; j < n1 - n2 + 1; j++) {
			ans = 0;
			for (k = 0; k < m2; k++) {
				for (l = 0; l < n2; l++) {
					ans += m[i + k][j + l] * core[k][l];
				}
			}
			printf("%d ", ans);
		}
		putchar('\n');
	}
	return 0;
}
