// #include <stdio.h>
// #include <math.h>

// #define MAX 10

// typedef struct m//marble info
// {
//     int redx;
//     int redy;
//     int bluex;
//     int bluey;
//     int count;
// }M;

// int i,j;

// char map[11][11];//map

// const int dx[4] = {-1,1,0,0};
// const int dy[4] = {0,0,-1,1};

// int queue[MAX*MAX][5];
// int front = 0;
// int rear = 0;

// void enque(M data){
//     queue[rear][0] = data.redx;
//     queue[rear][1] = data.redy;
//     queue[rear][2] = data.bluex;
//     queue[rear][3] = data.bluey;
//     queue[rear][4] = data.count;
//     rear++;
// }
// M deque(){
//     M data;
//     data.redx = queue[front][0];
//     data.redy = queue[front][1];
//     data.bluex = queue[front][2];
//     data.bluey = queue[front][3];
//     data.count = queue[front][4];
//     front++;
//     return data;
// }

// M mCord;//marble current coordinate

// int bfs(){
//     int visited[10][10][10][10] = {0,0,0,0};
//     visited[mCord.redx][mCord.redy][mCord.bluex][mCord.bluey] = 1;
//     int answer = -1;
//     while(rear != front){// rear != 0
//         printf("%d %d\n",front, rear);
//         M data = {0,};
//         data = deque();
//         if(data.count > 10) break;

//         if(map[data.redx][data.redy] == '0' && map[data.bluex][data.bluey] != '0'){
//             answer = data.count;
//             break;
//         }

//         for(int dir = 0; dir<4;dir++){
//             int rednx = data.redx;
//             int redny = data.redy;
//             int bluenx = data.bluex;
//             int blueny = data.bluey;

//             while(1){
//                 if(map[rednx][redny] != '#' && map[rednx][redny] != '0'){
//                     rednx += dx[dir];
//                     redny += dy[dir];
//                 }else{
//                     if(map[rednx][redny] == '#'){
//                         rednx -= dx[dir];
//                         redny -= dy[dir];
//                     }
//                     break;
//                 }
//             }
//             while(1){
//                 if(map[bluenx][blueny] == '#'){
//                     bluenx += dx[dir];
//                     blueny += dy[dir];
//                 }else{
//                     if(map[bluenx][blueny] == '#'){
//                         bluenx -= dx[dir];
//                         blueny -= dx[dir];
//                     }
//                     break;
//                 }
//             }
//             if(rednx == bluenx && redny == blueny){
//                 if(map[rednx][redny] != '0'){
//                     int redabs = abs(rednx - data.redx) + abs(redny - data.redy);
// 					int blue_abs = abs(bluenx - data.bluex) + abs(blueny - data.bluey);
// 					if(redabs > blue_abs) {// 더 먼 곳에서 온거
//                         rednx -= dx[dir];
//                         redny -= dy[dir];
                    
//                     }
// 					else {
//                         bluenx -= dx[dir];
//                         blueny -= dy[dir];
//                     }
//                 }
//             }

//             if(visited[rednx][redny][bluenx][blueny] == 0){
//                 visited[rednx][redny][bluenx][blueny] = 1;
//                 M next;
//                 next.redx = rednx;
//                 next.redy = redny;
//                 next.bluex = bluenx;
//                 next.bluey = blueny;
//                 next.count = data.count + 1;
//                 enque(next);
//             }

//         }
//     }
//     return answer;
// }



// int main(){
//     int n,m;
//     n=0;
//     m=0;
//     scanf("%d %d",&n,&m);
//     for(i=0;i<n;i++){
//         for(j=0;j<m;j++){
//             scanf("%c ", &map[i][j]);
//             if(map[i][j] == 'R') {
//                 mCord.redx = i;
//                 mCord.redy = j;
//             }
//             if(map[i][j] == 'B'){
//                 mCord.bluex = i;
//                 mCord.bluey = j;
//             } 
//         }
//     }
//     mCord.count = 0;
//     enque(mCord);
//     int answer = bfs();

//     printf("%d",answer);

//     return 0;
// }
// #include <stdio.h>

// #define MAX 500

// int arr[MAX][MAX];
// int n,m;

// int max(int a, int b){
//     if(a>b){
//         return a;
//     }
//     else{
//         return b;
//     }
// }

// int Isum(int x, int y){
//     int sum1=0, sum2 = 0;
//     if(x+4 < n){
//         for(int i=x;i<x+4;i++){
//             sum1 += arr[i][y];
//         }
//     }
//     if(y+4 < n){
//         for(int i=y;i<y+4;i++){
//             sum2 += arr[x][i];
//         }
//     }
//     return max(sum1,sum2);
// }

// int Osum(int x, int y){
//     int sum1=0;
//     if(x+1 < n && y+1 < m){
//         for(int i=x;i<x+1;i++){
//             for(int j=y; j<y+1;j++){
//                 sum1 += arr[i][j];
//             }
//         }
//     }
//     return sum1;
// }

// int Lsum(int x, int y){

// }

// int main(void){

//     scanf("%d %d",&n,&m);

//     if(n>MAX || m>MAX) return -1;

//     for(int i=0;i<n;i++){
//         for(int j=0;j<m; m++){
//             scanf("%d",&arr[i][j]);
//         }
//     }

//     return 0;
// }

#include <stdio.h>

#define MAX 1000002

int n,b,c;
int a[MAX];
long long answer = 0;


void direcSum(){
    for(int i=0; i<n; i++){
        a[i] -= b;
        answer++;
        if(a[i]>0){
            if(a[i] % c == 0){
                answer += (a[i]/c);
            }else{
                answer += (a[i]/c + 1);
            }
        }
    }
    return;
}

int main(){

    scanf("%d", &n);
    for(int i=0;i<n;i++){
        scanf("%d", &a[i]);
    }
    scanf("%d %d", &b, &c);
    direcSum();

    printf("%lld",answer);

    return 0;
}