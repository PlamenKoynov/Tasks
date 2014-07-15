#!/usr/bin/perl -w
use strict;
use IO::Socket::INET;

my $exit = "n";
#port: 
my $port = 8080 || die "Can't find port!\n";
#socket: 
my $socket = IO::Socket::INET -> new(
	PeerAddr 	=> 'localhost',
	PeerPort 	=> $port,
	Proto 		=> 'tcp'
	) || die "Can't establish socket: $!\n";

print "Connected to server!\n";

#izprashtane na danni
while($exit eq 'n')
{
	my $req;
	$req = <STDIN>;
	$socket->send($req);
	print "Data sent!\n";

	#poluchawane na otgowor ot server - a  
	$socket->recv(my $res, 1024);
	print $res;
	print "\n";

	do
	{
		print "Do you want to exit? [y/n]: ";
		$exit = <STDIN>;
		chomp($exit);
		$exit = lc($exit);
		print "\n";
	}
	while($exit ne 'y' && $exit ne 'n');

	#shutdown($socket, 1);
}
#zatwarqne na socket - a
$socket->close();
