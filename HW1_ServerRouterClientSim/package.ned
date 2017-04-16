package hw1_serverrouterclientsim;

@license(LGPL);
//
// TODO documentation
//
simple Server
{
    gates:
        inout in[];
}

simple Router
{
}

//
// TODO documentation
//
network Network
{
    @display("bgb=651,329");
    submodules:
        MainServer: Server {
            @display("p=342,165");
        }
        Router1: Router {
            @display("p=452,73");
        }

        Router2: Router {
            @display("p=202,73");
        }
}

