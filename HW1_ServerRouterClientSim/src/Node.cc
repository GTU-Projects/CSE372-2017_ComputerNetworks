//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

#include <src/Node.h>
#include <string.h>
#include "Server.h"

Define_Module(Node);

Node::Node() {
}

Node::~Node() {
}

void Node::initialize(){
    totalNode = par("totalNode");
}

void Node::handleMessage(cMessage *msg){
    char buffer[50];
    char receiver;
    int myIndex=0;
    int counter;

    sscanf(msg->getName(),"%d",&counter);
    if(counter!=30){
        counter++;
        // 1.node5
        sscanf(msg->getName(),"%d%c%c%d",&counter,&receiver,&receiver,&myIndex);

        if(rand()%2==0){ // send server
            sprintf(buffer,"%d.s",counter);
            send(new cMessage(buffer),"out");
        }else{
            int nodeID;
            do{
                nodeID = rand() % totalNode;
            }while(nodeID==getIndex());
            sprintf(buffer,"%d.n%d",counter,nodeID);
            send(new cMessage(buffer),"out");
        }
    }

}


