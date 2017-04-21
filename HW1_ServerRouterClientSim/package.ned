package hw1_serverrouterclientsim;

@license(LGPL);


simple Server
{
    int routerNum;
    int nodeNum;
    gates:
        input r_in[]; // router inputs - outputs
        output r_out[];
}


simple Node
{
    int totalNode;
    gates:
        input in;
        output out;
}

simple Router
{
    int nodeNum;
    gates:
        input s_in; // server inputs - outputs
        output s_out;
        input n_in[]; // client inputs outputs
        output n_out[];
        input r_in[]; // router intputs - outputs
        output r_out[];

}

network Network
{
    parameters:
        double n @prompt("Number of nodes");
        double r @prompt("Number of routers");
        @display("b=800,800");
    types:
        channel Channel extends ned.DelayChannel
        {
            delay = 250ms;
        }
    submodules:

        MainServer: Server {
            parameters:
                nodeNum = n;
                routerNum = r;
                @display("p=300,300");
        }

        router[r]: Router {
            parameters:
                nodeNum = n;
                @display("p=150,150,ri,150,150");

        }

        node[n*r]: Node {
            parameters:
                totalNode = n*r;
                @display("p=0,0,ri,300,300");
        }




    connections:
        // router - server connections
        for i=0..r-1 {
            MainServer.r_out++ --> Channel --> router[i].s_in;
            router[i].s_out --> Channel --> MainServer.r_in++;
        }

        // router - node connections
        for j=0..sizeof(node)-1 {
            node[j].out --> Channel --> router[j/n].n_in++;
            router[j/n].n_out++ --> Channel --> node[j].in;
        }

        // router out - router in connections
        router[0].r_out++ --> Channel --> router[r-1].r_in++;

        for i=1..r-1 {
            router[i].r_out++ --> Channel --> router[i-1].r_in++;
            router[i-1].r_out++ --> Channel --> router[i].r_in++;
        }

        router[r-1].r_out++ --> Channel --> router[0].r_in++;

}

