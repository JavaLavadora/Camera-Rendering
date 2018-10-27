 //CIRCULAR LIST
  class CircularList {
    
    int size =0;
    Node head=null;
    Node tail=null;
  
    public void addNodeAtStart(PVector coord){
        System.out.println("Adding node " + coord + " at start");
        PVector paux = new PVector (0, 0, 0);
        paux.x = coord.x;
        paux.y = coord.y;
        paux.z = coord.z;
        
        Node n = new Node(paux);
        if(size==0){
            head = n;
            tail = n;
            n.next = head;
        }else{
            Node temp = head;
            n.next = temp;
            head = n;
            tail.next = head;
        }
        size++;
    }
        
    public PVector elementAt(int index){
        if(index>size){
            return null;
        }
        Node n = head;
        while(index-1!=0){
            n=n.next;
            index--;
        }
        return n.tarCoord;
    }
    
    public void print(){
        System.out.print("Circular Linked List:");
        Node temp = head;
        if(size <= 0){
            System.out.print("List is empty");
        }else{
            do {
                System.out.print(" " + temp.tarCoord);
                temp = temp.next;
            }
            while(temp!=head);
        }
        System.out.println();
    }
    
    public int getSize(){
        return size;
    }
    
  }
  
class Node {
  PVector tarCoord = new PVector (0, 0, 0);
  Node next;
  
  Node(PVector tc){
     tarCoord = tc;
  }
}
  
