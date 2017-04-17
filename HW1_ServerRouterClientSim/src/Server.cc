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
    int nodeID = 1+rand()%4;
    char nodeInf[50];
    sprintf(nodeInf,"node%d",nodeID);
    cMessage *msg = new cMessage(nodeInf);

    //send(msg, "r_out",0);
    //for(int i=0;i<2;++i)

}

void Server::handleMessage(cMessage *msg){
    /*send(msg,"out");*/
}

