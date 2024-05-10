paran
#include<iostream>
#include<bits/stdc++.h>
using namespace std;

bool isBal(string s){
    stack<char> stk;
    for(char c : s){
        if(c == '{' || c == '(' || c == '[') stk.push(c);
        else{
            if(stk.empty()) return false;
            else if(stk.top() == '(' && c == ')') stk.pop();
            else if(stk.top() == '{' && c == '}') stk.pop();
            else if(stk.top() == '[' && c == ']') stk.pop();
            else{
                return false;
            }
        }
    }
    return stk.empty();
}
int main() {
    string str; cin >> str;
    if(isBal(str)) cout << "Yes";
    else cout << "No";
    return 0;
}
--------------------------------------------------------------
stock
#include<iostream>
#include <bits/stdc++.h>
using namespace std;

stack<pair<int,int>> stk;
int getPrice(int price){
    int count = 1;
    while(!stk.empty() && stk.top().first <= price){
        count += stk.top().second;
        stk.pop();
    }
    stk.push({price,count});
    return count;
}

int main() {
    vector<int> res;
    int n; cin >> n;
    while(n--){
        int val; cin >> val;
        res.push_back(getPrice(val));
    }

    for(auto i : res) cout << i << " ";
    cout << "END" << endl;
    return 0;
}
------------------------------------------------------
next greater
#include <bits/stdc++.h>
using namespace std;

vector<int> nge(vector<int>&nums){
    int n = nums.size();
    vector<int> res(n,-1);
    stack<int>st;
    for(int i=0;i<n*2;i++){
        while(!st.empty() && nums[i%n] > nums[st.top()]){
            res[st.top()] = nums[i%n];
            st.pop();
        }
        st.push(i%n);
    }
    return res;
}

int main() {
    int n; cin >> n; vector<int> arr; for(int i=0;i<n;i++){
        int val; cin >> val; arr.push_back(val);
    }
    vector<int> res = nge(arr);
    for(int i : res){
        cout << i << " ";
    }
}
----------------------------------------------------------
rat
#include <iostream>
#include <vector>
using namespace std;

const int N = 4; // Size of the maze

// Function to check if the given cell is valid to move
bool isValidMove(int maze[N][N], int x, int y) {
    return (x >= 0 && x < N && y >= 0 && y < N && maze[x][y] == 1);
}

// Function to solve the Rat in a Maze problem recursively
bool solveMazeUtil(int maze[N][N], int x, int y, vector<pair<int, int>>& path) {
    if (x == N - 1 && y == N - 1) {
        path.push_back({x, y});
        return true; // Reached the destination
    }

    if (isValidMove(maze, x, y)) {
        path.push_back({x, y});

        if (solveMazeUtil(maze, x + 1, y, path) || solveMazeUtil(maze, x, y + 1, path)) {
            return true;
        }

        path.pop_back(); // Backtrack if no path found
    }

    return false;
}

// Function to solve the Rat in a Maze problem
void solveMaze(int maze[N][N]) {
    vector<pair<int, int>> path;
    if (solveMazeUtil(maze, 0, 0, path)) {
        cout << "Path Found:" << endl;
        for (auto p : path) {
            cout << "(" << p.first << ", " << p.second << ")" << endl;
        }
    } else {
        cout << "No path found!" << endl;
    }
}

int main() {
    int maze[N][N];
    cout << "Enter the maze (0 for blocked, 1 for open):" << endl;
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            cin >> maze[i][j];
        }
    }

    solveMaze(maze);

    return 0;
}
--------------------
queen
#include <iostream>
#include <vector>
using namespace std;

void printSolution(const vector<vector<int>>& board) {
    int N = board.size();
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            cout << board[i][j] << " ";
        }
        cout << endl;
    }
}

bool isSafe(const vector<vector<int>>& board, int row, int col) {
    int N = board.size();
    // Check left side of the row
    for (int i = 0; i < col; ++i) {
        if (board[row][i])
            return false;
    }
    // Check upper diagonal on left side
    for (int i = row, j = col; i >= 0 && j >= 0; --i, --j) {
        if (board[i][j])
            return false;
    }
    // Check lower diagonal on left side
    for (int i = row, j = col; i < N && j >= 0; ++i, --j) {
        if (board[i][j])
            return false;
    }
    return true;
}

bool solveNQueensUtil(vector<vector<int>>& board, int col) {
    int N = board.size();
    if (col >= N) {
        return true; // All queens are placed successfully
    }
    for (int i = 0; i < N; ++i) {
        if (isSafe(board, i, col)) {
            board[i][col] = 1;
            if (solveNQueensUtil(board, col + 1))
                return true;
            board[i][col] = 0; // Backtrack if placing queen at (i, col) doesn't lead to a solution
        }
    }
    return false; // Could not place queen in this column
}

void solveNQueens(int N) {
    vector<vector<int>> board(N, vector<int>(N, 0));
    if (solveNQueensUtil(board, 0)) {
        cout << "Solution exists:" << endl;
        printSolution(board);
    } else {
        cout << "Solution does not exist!" << endl;
    }
}

int main() {
    int N;
    cout << "Enter the number of queens (N): ";
    cin >> N;
    solveNQueens(N);
    return 0;
}
------------------------------
hanoi
#include <iostream>
using namespace std;

void towerOfHanoi(int n, char from_rod, char to_rod, char aux_rod) {
    if (n == 1) {
        cout << "Move disk 1 from rod " << from_rod << " to rod " << to_rod << endl;
        return;
    }
    towerOfHanoi(n - 1, from_rod, aux_rod, to_rod);
    cout << "Move disk " << n << " from rod " << from_rod << " to rod " << to_rod << endl;
    towerOfHanoi(n - 1, aux_rod, to_rod, from_rod);
}

int main() {
    int n;
    cout << "Enter the number of disks: ";
    cin >> n;
    towerOfHanoi(n, 'A', 'C', 'B'); // A, B, and C are rod names
    return 0;
}
---------------------------
celeb
#include <iostream>
#include <vector>
using namespace std;

int findCelebrity(const vector<vector<int>>& mat) {
    int n = mat.size();
    int candidate = 0;
    for (int i = 1; i < n; ++i) {
        if (mat[candidate][i]) candidate = i;
    }
    for (int i = 0; i < n; ++i) {
        if (i != candidate && (mat[candidate][i] || !mat[i][candidate])) return -1;
    }
    return candidate;
}

int main() {
    int n;
    cout << "Enter the number of people: ";
    cin >> n;
    cout << "Enter the matrix representing who knows whom (1 if i knows j, 0 otherwise): " << endl;
    vector<vector<int>> mat(n, vector<int>(n));
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            cin >> mat[i][j];
        }
    }
    int celebrity = findCelebrity(mat);
    if (celebrity != -1)
        cout << "Celebrity: " << celebrity << endl;
    else
        cout << "No celebrity found" << endl;
    return 0;
}

