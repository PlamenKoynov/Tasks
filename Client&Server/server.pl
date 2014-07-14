#!usr/bin/perl -w
use strict;
use IO::Socket::INET;

my $data;
my $client;
my $socket;

my $port = shift or die "Can't find port!\n";

$socket = IO::Socket::INET->new(
	LocalPort	=> $port,
	Proto		=> 'tcp',
	Listen		=> SOMAXCONN)

while($client = $socket->accept())
{
	$port = $client->peerport;
	while(<$client>)
	{
		print "Client port: $port $_\n";
		print $client "$.:$_\n";
	}
	$data = "ok";
	$client->send($data);
	
	shutdown($client, 1);

	$socket->close();
}
