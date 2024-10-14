package ufnetwork.simulations;
package ufnetwork;

import inet.applications.tcpapp.TcpBasicClientApp;
import inet.applications.tcpapp.TcpClientApp;
import inet.applications.tcpapp.TelnetClientApp;
import inet.examples.ethernet.lans.cable;
import inet.examples.mobileipv6.ethernetline;
import inet.examples.mobileipv6.fiberline;
import inet.examples.wireless.throughput.WirelessAPWithSink;
import inet.linklayer.ieee8021as.GptpEndstation;
import inet.networklayer.configurator.ipv4.Ipv4FlatNetworkConfigurator;
import inet.networklayer.ipv4.Ipv4RoutingTable;
import inet.node.ethernet.Eth10G;
import inet.node.ethernet.Eth1G;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.wireless.AccessPoint;
import inet.tutorials.configurator.Eth100MLong;
import inet.tutorials.protocol.ServerHost1;
import inet.tutorials.protocol.ServerHost3;


@license(LGPL);
//
// TODO documentation
//
network UFNetwork
{
    parameters:
        int numClients = default(10); // Defina um valor padrão para o número de clientes
        @display("bgb=793,583");
    submodules:
        cticBorda: EthernetSwitch {
            @display("p=249,141");
        }
        leecBorda: EthernetSwitch {
            @display("p=324,149");
        }
        switch: EthernetSwitch {
            @display("p=408,168"); 
        }
        switch1: EthernetSwitch {
            @display("p=408,250");
        }
        switch2: EthernetSwitch {
            @display("p=408,338");
        }
        cliente: StandardHost {
            @display("p=605,143");
        }
        cliente1: StandardHost {
            @display("p=615,201");
        }
        cliente2: StandardHost {
            @display("p=632,293");
        }
        cliente3: StandardHost {
            @display("p=605,345");
        }
        cliente4: StandardHost {
            @display("p=471,475");
        }
        cliente5: StandardHost {
            @display("p=533,436");
        }
        cliente6: StandardHost {
            @display("p=408,475");
        }
        RNP: Router {
            @display("p=178,124");
        }
        eduroam: AccessPoint {
            @display("p=297,237");
        }
    connections allowunconnected: // Definições de conexão de nível de rede
        leecBorda.ethg[0] <--> fiberline {  delay = 0.1s; } <--> cticBorda.ethg[0];
        cticBorda.ethg[0] <--> Redundância: fiberline { @display("ls=red,3,s"); } <--> leecBorda.ethg[0];
        switch.ethg[0] <--> cable <--> cliente.ethg[0];
        switch.ethg[0] <--> cable <--> cliente1.ethg[0];
        switch2.ethg[0] <--> cable <--> cliente6.ethg[0];
        switch.ethg[0] <--> Eth1G <--> switch1.ethg[0];
        switch1.ethg[0] <--> Eth1G <--> switch2.ethg[0];
        RNP.ethg[0] <--> Eth10G <--> cticBorda.ethg[0];
        cticBorda.ethg[0] <--> Eth10G { @display("ls=#0080C0,3"); } <--> RNP.ethg[0];
        leecBorda.ethg[0] <--> Eth1G <--> switch.ethg[0];
        switch2.ethg[0] <--> cable <--> cliente4.ethg[0];
        switch2.ethg[0] <--> cable <--> cliente5.ethg[0];
        switch1.ethg[0] <--> cable <--> cliente3.ethg[0];
        switch1.ethg[0] <--> cable <--> cliente2.ethg[0];
        eduroam.ethg++ <--> inet.examples.inet.ipv4largenet.cable <--> switch.ethg[0];
}
