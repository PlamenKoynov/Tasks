#!/usr/bin/perl -w
use strict;
use IO::Socket::INET;

$| = 1;

#port: 
my $port = 8080 || die "Can't find port!\n";

#server:
my $server; 
$server = IO::Socket::INET->new(
	LocalAddr 	=> 'localhost',
	LocalPort	=> $port,
	Proto 		=> 'tcp',
	Listen		=> 5,
	Reuse		=> 1
) || die "Can't establish server: $!\n" unless $server;

print "The server is ready and is waiting clients!\nListening...\n";

while(my $client = $server->accept())
{	
	#informaciq za nowiq client:
	my $cl_addr = $client->peerhost();
	my $cl_port = $client->peerport(); 
	print "Connected: $cl_addr:$cl_port\n";
    
    while(1)
    {
		#chetene na informaciq
		my $data;
		$client->recv($data, 1024);
		print "Recieved data: $data";

		#izprashtane na informaciq
		$client->send("Everything is fine!\n");
	}	
	#shutdown($client, 1);
}
#zatvarqne na socket - a
$server->close();