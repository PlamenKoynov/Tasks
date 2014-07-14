#!/usr/bin/perl -w
use strict;
use Socket;

$| = 1;

my $proto = getprotobyname('tcp');
#protokola

#syzdawame si now socket
my $sock;
socket($sock, AF_INET, SOCK_STREAM, 0) || die $!; 

#syzdawane na port
my $port = 8888;

#swyrzwane socket - a s port - a
bind($sock, sockaddr_in($port, INADDR_ANY));
#bind - swyrzwa adresyt, sochen ot addr sys socket - a
#tozi proces e oshte izwesten kato: dawane na ime na socket - a
#INADDR_ANY - swyrzwa socket - a sys wsichki lokalni interfejsi

#socket - a zapochwa da slusha
listen($sock, 10);
#10 - maksimalnata dylzhina na zaqwkite, kojto mozhe da postypqt w opashkata

print "The server is now listening...\n";

while(1)
{
	my $client;
	my $addrinfo = accept($client, $sock);
	my($port, $iaddr) = sockaddr_in($addrinfo);
	my $name = gethostbyaddr($iaddr, AF_INET);
	print "Connection accepted from $name : $port\n";
	print $client "Hello, client!\n";
}

close($sock); 
