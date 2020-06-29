#include <stdio.h>
int n;
int G[81], vis[9];
int dfs(int cur, int num) {
	int i, ret = 0;
	if (num == n) {
		if (G[cur * 9 + 1]) return 1;
		else return 0;
	}
	vis[cur] = 1;
	for (i = 1; i <= n; i++) {
		if (G[cur * 9 + i] && !vis[i]) ret |= dfs(i, num + 1);
	}
	vis[cur] = 0;
	return ret;
}
int main() {
	int m, i, flag;
	scanf("%d%d", &n ,&m);
	for (i = 0; i < m; i++) {
		int tmp1, tmp2;
		scanf("%d%d", &tmp1, &tmp2);
		G[tmp1 * 9 + tmp2] = 1;
		G[tmp2 * 9 + tmp1] = 1;
	}
	flag = dfs(1, 1);
	printf("%d\n", flag);
	return 0;
}
