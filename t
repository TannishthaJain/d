lca
#include<bits/stdc++.h>
using namespace std;

class TreeNode{
public:
    int val;
    TreeNode* left, *right;
    TreeNode(int x){
        val = x;
        left = right = NULL;
    }
};

TreeNode* buildTree(){
    int val;
    string left;
    cin >> val >> left;

    TreeNode* root = new TreeNode(val);
    if(left == "true"){
        root->left = buildTree();
    }

    string right;
    cin >> right;
    if(right == "true"){
        root->right = buildTree();
    }
    return root;
}

TreeNode* lca(TreeNode* root, int p, int q){
    if(root == NULL) return NULL;
    if(root->val == p || root->val == q) return root;

    TreeNode* left = lca(root->left, p, q);
    TreeNode* right = lca(root->right, p, q);

    if(left != NULL && right != NULL) return root;
    if(left != NULL) return left;
    return right;
}

int main() {
    TreeNode* root = buildTree();
    int p, q; cin >> p >> q;
    TreeNode* res = lca(root, p, q);
    cout << res->val;
    return 0;
}
-----------------------------------------------
balanced
#include <bits/stdc++.h>
using namespace std;

class TreeNode{
public:
    int val;
    TreeNode* left, *right;
    TreeNode(int val){
        this->val = val;
        left = right = NULL;
    }
};

TreeNode* buildTree(){
    int val; cin >> val;
    string left; cin >> left;

    TreeNode* root = new TreeNode(val);
    if(left == "true"){
        root->left = buildTree();
    }
    string right; cin >> right;
    if(right == "true"){
        root->right = buildTree();
    }
    return root;
}

int depth(TreeNode* root){
    if(root == NULL) return 0;
    return max(depth(root->left), depth(root->right))+1;
}

bool isBalanced(TreeNode* root){
    if(root == NULL) return true;
    int left = depth(root->left);
    int right = depth(root->right);

    return abs(left-right) <= 1 && isBalanced(root->left) && isBalanced(root->right);
}

int main(){
    TreeNode* root = buildTree();
    if(isBalanced(root)) cout << "true";
    else cout << "false";
    return 0;
}
-----------------------------------------------------
sum
#include <iostream>
#include <queue>
using namespace std;

// Definition for a binary tree node.
struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

// Function to build a binary tree from user input.
TreeNode* buildTree() {
    cout << "Enter the value of root node: ";
    int val;
    cin >> val;
    TreeNode* root = new TreeNode(val);

    queue<TreeNode*> q;
    q.push(root);

    while (!q.empty()) {
        TreeNode* curr = q.front();
        q.pop();

        int leftVal, rightVal;
        cout << "Enter the left child value of " << curr->val << " (-1 for NULL): ";
        cin >> leftVal;
        if (leftVal != -1) {
            curr->left = new TreeNode(leftVal);
            q.push(curr->left);
        }

        cout << "Enter the right child value of " << curr->val << " (-1 for NULL): ";
        cin >> rightVal;
        if (rightVal != -1) {
            curr->right = new TreeNode(rightVal);
            q.push(curr->right);
        }
    }

    return root;
}

// Function to calculate the sum of leaf nodes in a binary tree.
int sumOfLeafNodes(TreeNode* root) {
    if (root == NULL)
        return 0;
    if (root->left == NULL && root->right == NULL)
        return root->val;
    return sumOfLeafNodes(root->left) + sumOfLeafNodes(root->right);
}

// Function to calculate the sum of non-leaf nodes in a binary tree.
int sumOfNonLeafNodes(TreeNode* root) {
    if (root == NULL || (root->left == NULL && root->right == NULL))
        return 0;
    return root->val + sumOfNonLeafNodes(root->left) + sumOfNonLeafNodes(root->right);
}

int main() {
    // Build binary tree
    TreeNode* root = buildTree();

    // Calculate sum of leaf nodes and non-leaf nodes
    int leafSum = sumOfLeafNodes(root);
    int nonLeafSum = sumOfNonLeafNodes(root);

    // Output results
    cout << "Sum of leaf nodes: " << leafSum << endl;
    cout << "Sum of non-leaf nodes: " << nonLeafSum << endl;

    return 0;
}

----------------------------------------------------
top
#include <iostream>
#include <queue>
#include <map>
#include <utility>
using namespace std;

class TreeNode {
public:
    int val;
    TreeNode* left, * right;
    TreeNode(int x) {
        val = x;
        left = right = NULL;
    }
};

TreeNode* buildTree() {
    int val; cin >> val;
    TreeNode* root = new TreeNode(val);

    queue<TreeNode*> q{{root}};
    while (!q.empty()) {
        auto temp = q.front();
        q.pop();

        int leftVal, rightVal;
        cin >> leftVal >> rightVal;

        if (leftVal != -1) {
            temp->left = new TreeNode(leftVal);
            q.push(temp->left);
        }
        if (rightVal != -1) {
            temp->right = new TreeNode(rightVal);
            q.push(temp->right);
        }
    }
    return root;
}

void topView(TreeNode* root) {
    if (root == NULL) return;
    queue<pair<TreeNode*, int>> q;
    map<int, int> topViewMap;

    q.push({root, 0});
    while (!q.empty()) {
        auto temp = q.front();
        q.pop();
        TreeNode* curr = temp.first;
        int horD = temp.second;

        if (topViewMap.find(horD) == topViewMap.end()) {
            topViewMap[horD] = curr->val;
        }
        if (curr->left != NULL) {
            q.push({curr->left, horD - 1});
        }
        if (curr->right != NULL) {
            q.push({curr->right, horD + 1});
        }
    }

    for (auto it : topViewMap) {
        cout << it.second << " ";
    }
}

int main() {
    TreeNode* root = buildTree();
    topView(root);
    return 0;
}
-----------------------------------------------------
trav
#include <iostream>
#include <queue>
#include <sstream>
#include <string>
#include <vector>
using namespace std;

struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

TreeNode* deserialize(string data) {
    if (data.empty() || data == "null" || data == "-1") return nullptr;
    stringstream ss(data);
    string token;
    getline(ss, token, ' ');
    TreeNode* root = new TreeNode(stoi(token));
    queue<TreeNode*> q;
    q.push(root);
    while (!q.empty()) {
        TreeNode* node = q.front();
        q.pop();
        if (getline(ss, token, ' ')) {
            if (token != "null" && token != "-1") {
                node->left = new TreeNode(stoi(token));
                q.push(node->left);
            }
        }
        if (getline(ss, token, ' ')) {
            if (token != "null" && token != "-1") {
                node->right = new TreeNode(stoi(token));
                q.push(node->right);
            }
        }
    }
    return root;
}


vector<vector<int>> levelOrder(TreeNode *root){
   inorder(root);
    cout << endl;
    preorder(root);
    cout << endl;
    postorder(root);
    cout << endl;
    return {};
}
void inorder(TreeNode* root){
    if(root!=NULL){
        inorder(root->left);
        cout<<root->val<<" ";
        inorder(root->right);
    }
}
void preorder(TreeNode* root){
   if(root!=NULL){
        cout<<root->val<<" ";
        preorder(root->left);
        preorder(root->right);
    }
}
void postorder(TreeNode* root){
   if(root!=NULL){
        postorder(root->left);
        postorder(root->right);
        cout<<root->val<<" ";
    }
}

int main() {
    int n;
    cout << "Enter the number of test cases: ";
    cin >> n;
    cin.ignore(); // Ignore the newline character after reading n
    
    vector<TreeNode*> trees;
    for (int i = 0; i < n; ++i) {
        string input;
        cout << "Enter the binary tree for test case " << i+1 << " in level order traversal format: ";
        getline(cin, input);
        TreeNode* root = deserialize(input);
        trees.push_back(root);
    }

    cout << " Traversals of the trees:" << endl;
    for (int i = 0; i < n; ++i) {
        cout << "Test case " << i+1 << ": ";
        inorder(trees[i]);
        cout<<endl;
        preorder(trees[i]);
        cout<<endl;
        postorder(trees[i]);
        
        cout << endl;
    }

    return 0;
}
------------------------------------------------
left right
#include <iostream>
#include <vector>
#include <queue>
#include <sstream>
using namespace std;

// Definition for a binary tree node.
struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

// Function to build a binary tree from input string.
TreeNode* buildTree(const vector<string>& nodes) {
    if (nodes.empty() || nodes[0] == "null")
        return nullptr;

    TreeNode* root = new TreeNode(stoi(nodes[0]));
    queue<TreeNode*> q;
    q.push(root);

    for (int i = 1; i < nodes.size(); i += 2) {
        TreeNode* curr = q.front();
        q.pop();

        if (nodes[i] != "null") {
            curr->left = new TreeNode(stoi(nodes[i]));
            q.push(curr->left);
        }

        if (i + 1 < nodes.size() && nodes[i + 1] != "null") {
            curr->right = new TreeNode(stoi(nodes[i + 1]));
            q.push(curr->right);
        }
    }

    return root;
}

// Function for right view of a binary tree.
vector<int> rightSideView(TreeNode* root) {
    vector<int> ans;
    if (root == nullptr)
        return ans;

    queue<TreeNode*> q;
    q.push(root);

    while (!q.empty()) {
        int size = q.size();
        for (int i = 0; i < size; ++i) {
            TreeNode* node = q.front();
            q.pop();
            if (i == size - 1) ans.push_back(node->val);
            if (node->left) q.push(node->left);
            if (node->right) q.push(node->right);
        }
    }

    return ans;
}

int main() {
    cout << "Enter the binary tree in the format [3,9,20,null,null,15,7]: ";
    string input;
    getline(cin, input);

    // Removing brackets and splitting input string by comma
    input = input.substr(1, input.size() - 2);
    stringstream ss(input);
    vector<string> nodes;
    string node;
    while (getline(ss, node, ','))
        nodes.push_back(node);

    // Building binary tree
    TreeNode* root = buildTree(nodes);

    // Finding the right view of the binary tree
    vector<int> result = rightSideView(root);

    // Output result
    cout << "Right view of the binary tree: [";
    for (int i = 0; i < result.size(); ++i) {
        cout << result[i];
        if (i != result.size() - 1) cout << ",";
    }
    cout << "]" << endl;

    return 0;
}
--------------------------------------------------------------
