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

simple Router
{
    gates:
        input s_in[]; // server inputs - outputs
        output s_out[];
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
    @display("bgb=651,329");
    submodules:
        MainServer: Server {
            @display("p=343,257");
        }
        Router1: Router {
            @display("p=440,165");
        }

        Router2: Router {
            @display("p=241,165");
        }
        node1: Node {
            @display("p=116,165");
        }
        node2: Node {
            @display("p=241,51");
        }
        node3: Node {
            @display("p=440,51");
        }
        node4: Node {
            @display("p=559,165");
        }
    connections:
        Router2.s_out++ --> MainServer.r_in++;
        MainServer.r_out++ --> Router2.s_in++;
        Router1.s_out++ --> MainServer.r_in++;
        MainServer.r_out++ --> Router1.s_in++;
        node3.out --> {  delay = 250ms; } --> Router1.c_in++;
        Router1.c_out++ --> node3.in;
        node4.out --> {  delay = 250ms; } --> Router1.c_in++;
        Router1.c_out++ --> node4.in;
        node2.out --> {  delay = 250ms; } --> Router2.c_in++;
        Router2.c_out++ --> node2.in;
        Router2.c_out++ --> node1.in;
        node1.out --> {  delay = 250ms; } --> Router2.c_in++;
        Router2.r_out++ --> Router1.r_in++;
        Router1.r_out++ --> Router2.r_in++;
}

