package hw1_serverrouterclientsim;

@license(LGPL);
//
// TODO documentation
//

simple Server
{
    int routerNum;
    int nodeNum;
    gates:
        input r_in[]; // router inputs - outputs
        output r_out[];
}

//
// TODO documentation
//
simple Node
{
    int totalNode;
    gates:
        input in;
        output out;
}

simple Router{
    int nodeNum;
    gates:
        input s_in; // server inputs - outputs
        output s_out;
        input n_in[]; // client inputs outputs
        output n_out[];
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
        double r @prompt("Number of routers") = default(6);
        @display("b=800,800");
    submodules:

        MainServer: Server {
            parameters:
                nodeNum=n;
                routerNum=r;
            @display("p=300,300");
        }

        router[r]: Router{
        	parameters:
        	    nodeNum=n;
        	@display("p=150,150,ri,150,150");
        	
        };
        
        node[n*r]: Node{
            parameters:
                totalNode = n*r;
            @display("p=0,0,ri,300,300");
        };


    connections:
        // router - server connections
        for i=0..r-1{
        	MainServer.r_out++ --> {  delay = 250ms; } --> router[i].s_in;
        	router[i].s_out --> {  delay = 250ms; } --> MainServer.r_in++;
        }
        
        // router - node connections
        for j=0..sizeof(node)-1{
        	node[j].out --> {  delay = 250ms; } --> router[j/n].n_in++;
        	router[j/n].n_out++ --> {  delay = 250ms; } --> node[j].in;
        }
        
        // router out - router in connections
        router[0].r_out++ --> {delay = 250ms;} --> router[r-1].r_in++;
        
        for i=1..r-1{
            router[i].r_out++ --> {  delay = 250ms; } --> router[i-1].r_in++;
            router[i-1].r_out++ --> {  delay = 250ms; } --> router[i].r_in++;
        }
        
        router[r-1].r_out++ --> {  delay = 250ms; } --> router[0].r_in++;
           
        
    
        
        
}

