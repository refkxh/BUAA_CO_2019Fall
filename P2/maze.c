#include <stdio.h>
int n, m, tx, ty, ans = 0;
int M[8][8], vis[8][8];
void dfs(int curx, int cury) {
	int dx, dy;
	if (curx == tx && cury == ty) {
		ans++;
		return;
	}
	dx = curx - 1;
	if (dx > 0 && dx <= n) {
		if (!vis[dx][cury] && !M[dx][cury]) {
			vis[dx][cury] = 1;
			dfs(dx, cury);
			vis[dx][cury] = 0;
		}
	}
	dx = curx + 1;
	if (dx > 0 && dx <= n) {
		if (!vis[dx][cury] && !M[dx][cury]) {
			vis[dx][cury] = 1;
			dfs(dx, cury);
			vis[dx][cury] = 0;
		}
	}
	dy = cury - 1;
	if (dy > 0 && dy <= m) {
		if (!vis[curx][dy] && !M[curx][dy]) {
			vis[curx][dy] = 1;
			dfs(curx, dy);
			vis[curx][dy] = 0;
		}
	}
	dy = cury + 1;
	if (dy > 0 && dy <= m) {
		if (!vis[curx][dy] && !M[curx][dy]) {
			vis[curx][dy] = 1;
			dfs(curx, dy);
			vis[curx][dy] = 0;
		}
	}
}
int main() {
	int i, j, sx, sy;
	scanf("%d%d", &n, &m);
	for (i = 1; i <= n; i++) {
		for (j = 1; j <= m; j++) {
			scanf("%d", &M[i][j]);
		}
	}
	scanf("%d%d%d%d", &sx, &sy, &tx, &ty);
	vis[sx][sy] = 1;
	dfs(sx, sy);
	printf("%d\n", ans);
	return 0;
}
