#!/usr/bin/perl -w
use strict;
use IO::Socket::INET;

#port: 
my $port = 8080 || die "Can't find port!\n";
#socket: 
my $socket = IO::Socket::INET -> new(
	LocalAddr 	=> 'localhost',
	LocalPort 	=> $port,
	Proto 		=> 'tcp'
	) || die "Can't establish socket: $!\n";

print "Connected to server!\n";

#izprashtane na danni
my $req = "Hello, world!\n";
$socket->send($req);
print "Data sent!\n";

#poluchawane na otgowor ot server - a  
$socket->recv(my $res, 1024);
print $res;
print "\n";

shutdown($socket, 1);

#zatwarqne na socket - a
$socket->close();
