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

void Server::initialize(){
    int routerWay;

    srand(time(NULL));

    nodeNum = par("nodeNum");
    routerNum = par("routerNum");

    cMessage *msg = getRandomNodeMsg(routerWay);
    send(msg, "r_out",routerWay);
}

void Server::handleMessage(cMessage *msg){
    if(msg->getPreviousEventNumber()!=30){ // yeni mesaj olustur ve yolla
        int routerWay;
        cMessage *msg1 = getRandomNodeMsg(routerWay);
        send(msg1, "r_out",routerWay); // router outtan yeni mesajı yolla
    }
}

// random mesaj uretir ve gidecegi router kapısını parametre ile return eder
cMessage* Server::getRandomNodeMsg(int &routerWay){
    char buffer[20];
    cMessage *msg;
    int nodeID = rand() % (nodeNum*routerNum);
    sprintf(buffer,"n%d",nodeID);
    msg = new cMessage(buffer);

    routerWay = (nodeID / nodeNum);
    return msg;
}

