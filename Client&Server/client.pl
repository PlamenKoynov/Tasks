#!usr/bin/perl -w
use strict;
use IO::Socket::INET;

my $server = shift;
my $port = shift || die "Can't find port!";

my $socket = IO::Socket::INET->new(
	PeerAddr	=> $server,
	PeerPort	=> $port,
	Proto		=> 'tcp');

print $socket "Hello, server!";

shutdown($socket, 1);

my $response = "";
$socket->recv($response, 1024);
print "$response\n";

$socket->close();	
