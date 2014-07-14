#!/usr/bin/perl -w
use strict;
use Socket;

#protokola
$proto = getprotobyname('tcp');
#vidyt na protokola e tcp
#ekvivalent na gorniq red w IO::Socket::Inet e Proto => 'tcp'

#socket - a 
my($sock);
socket($sock, AF_INET, SOCK_STREAM, $proto) or die $!;

#AF_INET - address family, w UNIX ima oshte 29 podobni adresni semejstva
#die $! - izwezhda greshkata, koqto e wyzniknala

$remote = 'www.abv.bg';
#$remote - syrwyryt, kym kojto se swyrzwame

$port = 80;
#$port - portyt, prez kojto go pravim 

$iaddr = inet_aton($remote);
#wzemame adresyt na syrwyra i go prewryshtame w chisla (dylyg format)

$paddr = socketaddr_in($port, $iaddr);
#w $paddr se pazi informaciq za adresa na syrwyra, za tipa na adresa i porta

connect($sock, $paddr) || die "No connection: $!\n";
#swyrzwame socket - a sys syrwyra
#pri greshka w swyrzwaneto, izwezhdame syobshtenie za greshka

print "Connected to $remote or port $port!\n";
#ako wsichko e uspeshno, izwezhdame syobshtenie, che e swyrzano uspeshno

send($sock, "GET/HTTP/1.1\r\n\r\n", 0) || die "Couldn't send information! $!\n";
#izprashtane na informaciq 
#"GET/HTTP/1.1\r\n\r\n" - informaciq za source koda na syrvyra, kojto dostypvame
#0 - flag 

while($line = <$sock>)
{
	print $line;
}
#poluchawane na otgowor ot syrwyra
#drug vyzmozhen variant e:
#recv($sock, $msg, 2000, 0)
#$sock - socket - a
#$msg - syobshtenieto ili buffer - a
#2000 - goleminata na buffer - a
#0 - flag

close($sock);
#zatvarqne na socket - a 
#close() - zatwarq socket - a 
  

