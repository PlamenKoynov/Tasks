#!usr/bin/perl -w
use strict;
use Socket;

my $remote = 'localhost';
my $proto = getprotobyname('tcp');
my $port = 8888;
my($sock);
socket($sock, AF_INET, SOCK_STREAM, $proto) || die $!;

my $iaddr = inet_aton($remote) || die $!;
my $paddr = sockaddr_in($port, $iaddr) || die $!;

connect($sock, $paddr) || die $!;
print "Connected to $remote on port $port";

#send($sock, "POST Hello", 0) || die $!;
print $sock "Hello, there!\nI'm your client!\n";
while(my $line = <$sock>)
{
	print $line;
}

close($sock);
