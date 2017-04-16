#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

class Server : public cSimpleModule
{
  protected:
    // The following redefined virtual function holds the algorithm.
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};

// The module class needs to be registered with OMNeT++
Define_Module(Server);

void Server::initialize()
{

    if (strcmp("tic", getName()) == 0) {
        cMessage *msg = new cMessage("tictocMsg");
        send(msg, "out");
    }
}

void Server::handleMessage(cMessage *msg)
{

    send(msg, "out"); // send out the message
}

