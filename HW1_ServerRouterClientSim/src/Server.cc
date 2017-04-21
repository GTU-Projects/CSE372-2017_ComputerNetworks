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

#include <Server.h>
#include <cstdlib>
#include <cstring>
#include <string>

Define_Module(Server);

using namespace std;

Server::Server() {
}

Server::~Server() {
    // TODO Auto-generated destructor stub
}
void Server::initialize(){
    srand(time(NULL));
    int routerWay;
    nodeNum = par("nodeNum");
    routerNum = par("routerNum");

    cMessage *msg = getRandomNodeMsg(0,routerWay);


    send(msg, "r_out",routerWay);

}

void Server::handleMessage(cMessage *msg){

    int iTemp;
    sscanf(msg->getName(),"%d",&iTemp);
    if(iTemp!=30){
        int routerWay;
        cMessage *msg1 = getRandomNodeMsg(++iTemp,routerWay);
        send(msg1, "r_out",routerWay);
    }
}

cMessage* Server::getRandomNodeMsg(int num,int &routerWay){
    char nodeInf[50];
    cMessage *msg;
    int nodeID = rand() % (nodeNum*routerNum);
    sprintf(nodeInf,"%d.n%d",num,nodeID);
    msg = new cMessage(nodeInf);

    routerWay = (nodeID / nodeNum);
    return msg;
}

