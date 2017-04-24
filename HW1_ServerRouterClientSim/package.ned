package hw1_serverrouterclientsim;
@license(LGPL);

// Hasan Men - CSE372 Ağ HW1
//
//Maximum 30tane mesaj üretip server-router-client arasında iletimini simule eder.
//
//
simple Server{
    int routerNum; // servere baglı router sayısı
    int nodeNum; // serverin erisebilecegi node sayısı
    gates:
        input r_in[]; // router inputs - outputs
        output r_out[];
}

simple Node{
    int totalNode; // toplam node sayisi - random sayi uretmek icin
    gates:
        input r_in;
        output r_out;
}

simple Router{
    int nodeNum; // routere baglı node sayisi
    gates:
        input s_in;
        output s_out;
        input n_in[];
        output n_out[];
        input r_in[];
        output r_out[];
}

network Network{
    parameters:
        double n @prompt("number of nodes per router"); // = default(3);
        double r @prompt("number of routers");  // = default(3);
        @display("b=1000,1000");
    types:
        // delayed chanel
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
            MainServer.r_out++ --> {delay = 250ms;} --> router[i].s_in;
            router[i].s_out --> {delay = 250ms;} --> MainServer.r_in++;
        }

        // router - node connections
        for j=0..sizeof(node)-1 {
            node[j].r_out --> {delay = 250ms;} --> router[j/n].n_in++;
            router[j/n].n_out++ --> {delay = 250ms;} --> node[j].r_in;
        }

        // router out - router in connections
        router[0].r_out++ --> {delay = 250ms;} --> router[r-1].r_in++;
        for i=1..r-1 {
            router[i].r_out++ --> {delay = 250ms;} --> router[i-1].r_in++;
            router[i-1].r_out++ --> {delay = 250ms;} --> router[i].r_in++;
        }
        router[r-1].r_out++ --> {delay = 250ms;} --> router[0].r_in++;
        

}

