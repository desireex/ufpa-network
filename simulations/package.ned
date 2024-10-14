package ufnetwork.simulations;

@license(LGPL);
import inet.applications.tcpapp.TcpBasicClientApp;
//
// TOimport inet.applications.tcpapp.TcpBasicClientApp;
import inet.applications.tcpapp.TcpClientApp;
import inet.applications.tcpapp.TelnetClientApp;
import inet.examples.mobileipv6.ethernetline;
import inet.examples.mobileipv6.fiberline;
import inet.linklayer.ieee8021as.GptpEndstation;
import inet.networklayer.configurator.ipv4.Ipv4FlatNetworkConfigurator;
import inet.node.ethernet.Eth1G;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.tutorials.configurator.Eth100MLong;
import inet.tutorials.protocol.ServerHost1;
import inet.tutorials.protocol.ServerHost3;
//
// TODO documentation
//
network UFNetwork
{
    parameters:
        int numClients = default(10); // Defina um valor padrão para o número de clientes
        @display("bgb=589,358");
    submodules:
        configurator: Ipv4FlatNetworkConfigurator {
            @display("p=100,50");
        } // Autoconfigurador de rede

        server: StandardHost {
            @display("p=100,150");
        } // Servidor

        router: Router {
            @display("p=200,100");
        } // Roteador

        switch: EthernetSwitch {
            @display("p=280,95");
        } // Switch Ethernet

        client[numClients]: StandardHost {  // Número de clientes baseado no parâmetro
            @display("p=355,95");
        }
        tcpBasicClientApp1: TcpBasicClientApp {
            @display("p=350,182");
        }
    connections allowunconnected: // Definições de conexão de nível de rede
        router.pppg++ <--> fiberline{
        delay= 5ms;
        datarate=2bps;} <--> server.pppg++; // Conexão PPP (Ponto-a-Ponto)

        switch.ethg++ <--> fiberline{
        delay= 5ms;
        datarate=2bps;} <--> router.ethg++; // Ethernet entre roteador e switch

        for i=0..numClients-1 {
            client[i].ethg++ <--> fiberline{
        delay= 5ms;
        datarate=2bps;} <--> switch.ethg++; // Ethernet para cada cliente
        }
}
