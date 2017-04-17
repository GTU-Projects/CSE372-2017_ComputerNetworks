package hw1_serverrouterclientsim;

@license(LGPL);
//
// TODO documentation
//

simple Server
{
    gates:
        input r_in[]; // router inputs - outputs
        output r_out[];
}

//
// TODO documentation
//
simple Node
{
    
    gates:
        input in;
        output out;
}

simple Router{
    int nodeNum;
        
    gates:
        input s_in; // server inputs - outputs
        output s_out;
        input c_in[]; // client inputs outputs
        output c_out[];
        input r_in[]; // router intputs - outputs
        output r_out[];
        
}



//
// TODO documentation
//
network Network
{
    
    parameters:
        double n @prompt("Number of nodes") = default(3);
        double r @prompt("Number of routers") = default(5);
        @display("b=800,800");
    submodules:

        MainServer: Server {
            @display("p=300,300");
        }

        router[r]: Router{
        	parameters:
        	    nodeNum=n;
        	@display("p=150,150,ri,150,150");
        	
        };
        
        node[n*r]: Node{
            @display("p=0,0,ri,300,300");
        };


    connections:
        // router - server connections
        for i=0..r-1{
        	MainServer.r_out++ --> router[i].s_in;
        	router[i].s_out --> MainServer.r_in++;
        }
        
        // router - node connections
        for j=0..sizeof(node)-1{
        	node[j].out --> router[j/n].c_in++;
        	router[j/n].c_out++ --> node[j].in;
        }
        
        // router out - router in connections
        for i=0..r-2{
        	router[i].r_out++ --> router[i+1].r_in++;
        	router[i+1].r_out++ --> router[i].r_in++;
        }
        router[r-1].r_out++ --> router[0].r_in++;
        router[0].r_out++ --> router[r-1].r_in++;
        
        
}

