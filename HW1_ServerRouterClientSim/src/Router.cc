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

void Router::initialize(){
    nodeNum = par("nodeNum"); //baglı node sayisini .ned ten oku
}

void Router::handleMessage(cMessage *msg){

    int way; // mesajın hangi kapıdan gidecegi
    char receiver; // alici

    if(msg->getPreviousEventNumber()!=30){
        sscanf(msg->getName(),"%c%d",&receiver,&way);
        if(receiver=='n'){
            // aynı router altında ise
            if(way>=getIndex()*nodeNum && way<(getIndex()+1)*nodeNum)
                send(msg,"n_out",way%nodeNum);
            else{
                if(way<(getIndex()*nodeNum)) // en yakın routere gonder
                    send(msg,"r_out",0);
                else send(msg,"r_out",1);
            }
        }else{ // servere gonder
            send(msg,"s_out");
        }
    }
}

