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

#include <Router.h>
#include "Server.h"

Define_Module(Router);

Router::Router() {
    // TODO Auto-generated constructor stub

}

Router::~Router() {
    // TODO Auto-generated destructor stub
}

void Router::initialize(){
    nodeNum = par("nodeNum");
}

void Router::handleMessage(cMessage *msg){

    int way;
    char receiver;
    int counter;

    // 0.node5
    // 1.server
    sscanf(msg->getName(),"%d",&counter);
    if(counter!=30){
        sscanf(msg->getName(),"%d%c%c%d",&counter,&receiver,&receiver,&way);

        if(receiver=='n'){
            // aynı router altında ise
            if(way>=getIndex()*nodeNum && way<(getIndex()+1)*nodeNum)
                send(msg,"n_out",way%nodeNum);
            else{
                send(msg,"r_out",0);
            }
        }else{
            send(msg,"s_out");
        }
    }
}

