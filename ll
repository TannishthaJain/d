#include <iostream>
using namespace std;

// Definition for singly-linked list node.
class Node {
public:
    int data;
    Node* next;

    Node(int val) {
        data = val;
        next = NULL;
    }
};

// Function to insert a node at the beginning of the linked list.
Node* insertAtBeginning(Node* head, int val) {
    Node* newNode = new Node(val);
    newNode->next = head;
    return newNode;
}

// Function to insert a node at the end of the linked list.
Node* insertAtEnd(Node* head, int val) {
    Node* newNode = new Node(val);
    if (head == NULL)
        return newNode;
    Node* temp = head;
    while (temp->next != NULL)
        temp = temp->next;
    temp->next = newNode;
    return head;
}

// Function to insert a node at the middle of the linked list.
Node* insertAtMiddle(Node* head, int val, int position) {
    Node* newNode = new Node(val);
    if (position == 0) {
        newNode->next = head;
        return newNode;
    }
    Node* temp = head;
    for (int i = 0; i < position - 1 && temp != NULL; ++i)
        temp = temp->next;
    if (temp == NULL)
        return head;
    newNode->next = temp->next;
    temp->next = newNode;
    return head;
}

// Function to delete a node at the beginning of the linked list.
Node* deleteAtBeginning(Node* head) {
    if (head == NULL)
        return NULL;
    Node* temp = head->next;
    delete head;
    return temp;
}

// Function to delete a node at the end of the linked list.
Node* deleteAtEnd(Node* head) {
    if (head == NULL || head->next == NULL) {
        delete head;
        return NULL;
    }
    Node* temp = head;
    while (temp->next->next != NULL)
        temp = temp->next;
    delete temp->next;
    temp->next = NULL;
    return head;
}

// Function to delete a node at the middle of the linked list.
Node* deleteAtMiddle(Node* head, int position) {
    if (head == NULL)
        return NULL;
    if (position == 0) {
        Node* temp = head->next;
        delete head;
        return temp;
    }
    Node* temp = head;
    for (int i = 0; i < position - 1 && temp != NULL; ++i)
        temp = temp->next;
    if (temp == NULL || temp->next == NULL)
        return head;
    Node* toDelete = temp->next;
    temp->next = temp->next->next;
    delete toDelete;
    return head;
}

// Function to print the linked list.
void printList(Node* head) {
    Node* temp = head;
    while (temp != NULL) {
        cout << temp->data << " ";
        temp = temp->next;
    }
    cout << endl;
}

int main() {
    Node* head = NULL;

    // Insertion at the beginning
    int n;
    cout << "Enter the number of elements to insert at the beginning: ";
    cin >> n;
    cout << "Enter the elements: ";
    for (int i = 0; i < n; ++i) {
        int val;
        cin >> val;
        head = insertAtBeginning(head, val);
    }
    cout << "After insertion at the beginning: ";
    printList(head);

    // Insertion at the end
    cout << "Enter the number of elements to insert at the end: ";
    cin >> n;
    cout << "Enter the elements: ";
    for (int i = 0; i < n; ++i) {
        int val;
        cin >> val;
        head = insertAtEnd(head, val);
    }
    cout << "After insertion at the end: ";
    printList(head);

    // Insertion at the middle
    cout << "Enter the position to insert at the middle: ";
    int position;
    cin >> position;
    cout << "Enter the element: ";
    int val;
    cin >> val;
    head = insertAtMiddle(head, val, position);
    cout << "After insertion at the middle: ";
    printList(head);

    // Deletion at the beginning
    head = deleteAtBeginning(head);
    cout << "After deletion at the beginning: ";
    printList(head);

    // Deletion at the end
    head = deleteAtEnd(head);
    cout << "After deletion at the end: ";
    printList(head);

    // Deletion at the middle
    cout << "Enter the position to delete at the middle: ";
    cin >> position;
    head = deleteAtMiddle(head, position);
    cout << "After deletion at the middle: ";
    printList(head);

    return 0;
}
----------------------
sum
#include <iostream>
using namespace std;

// Definition for singly-linked list node.
class ListNode {
public:
    int val;
    ListNode* next;

    ListNode(int x) : val(x), next(NULL) {}
};

// Function to add two numbers represented as linked lists.
ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
    ListNode dummyHead(0);
    ListNode* p = &dummyHead;
    int carry = 0;

    while (l1 != NULL || l2 != NULL || carry != 0) {
        int sum = carry;
        if (l1 != NULL) {
            sum += l1->val;
            l1 = l1->next;
        }
        if (l2 != NULL) {
            sum += l2->val;
            l2 = l2->next;
        }
        p->next = new ListNode(sum % 10);
        carry = sum / 10;
        p = p->next;
    }

    return dummyHead.next;
}

int main() {
    // Constructing two numbers represented as linked lists
    ListNode* l1 = new ListNode(2);
    l1->next = new ListNode(4);
    l1->next->next = new ListNode(3);

    ListNode* l2 = new ListNode(5);
    l2->next = new ListNode(6);
    l2->next->next = new ListNode(4);

    // Adding the two numbers
    ListNode* result = addTwoNumbers(l1, l2);

    // Printing the result
    cout << "Sum of the two numbers: ";
    ListNode* current = result;
    while (current != NULL) {
        cout << current->val;
        if (current->next != NULL)
            cout << " -> ";
        current = current->next;
    }
    cout << endl;

    return 0;
}
-------------------------------------------
triplet
#include <iostream>

using namespace std;

class Node {
public:
    int data;
    Node* next;
    Node(int data){
        this->data = data;
        next = NULL;
    }
};

void insertAtEnd(Node*& head, int val) {
    Node* newNode = new Node(val);
    if (!head) {
        head = newNode;
        return;
    }
    Node* temp = head;
    while (temp->next) {
        temp = temp->next;
    }
    temp->next = newNode;
}

void findNodes(Node* head1, Node* head2, Node* head3, int target) {
    Node* ptr1 = head1;
    while (ptr1) {
        Node* ptr2 = head2;
        while (ptr2) {
            Node* ptr3 = head3;
            while (ptr3) {
                int sum = ptr1->data + ptr2->data + ptr3->data;
                if (sum == target) {
                    cout << ptr1->data << " " << ptr2->data << " " << ptr3->data << endl;
                    return;
                }
                ptr3 = ptr3->next;
            }
            ptr2 = ptr2->next;
        }
        ptr1 = ptr1->next;
    }
}

int main() {
    int n, m, o;
    cin >> n >> m >> o;
    Node* head1 = nullptr, *head2 = nullptr, *head3 = nullptr;
    for (int i = 0; i < n; i++) {
        int val;
        cin >> val;
        insertAtEnd(head1, val);
    }
    for (int i = 0; i < m; i++) {
        int val;
        cin >> val;
        insertAtEnd(head2, val);
    }
    for (int i = 0; i < o; i++) {
        int val;
        cin >> val;
        insertAtEnd(head3, val);
    }
    int target;
    cin >> target;
    findNodes(head1, head2, head3, target);
    return 0;
}
------------------------------------
