#!/usr/bin/perl -w
use strict;

my $size = 1;
my $counter = 0;
my $n;
my $k = 10;

do
{
	print "Position: \n";
	$n = <STDIN>;
	chomp($n);
}
while($n <= 0 || $n > 3200000);

my $temp = 1;
for($temp = 1; $temp <= $n; $temp += 1)
{
	if($temp * $temp >= $k)
	{
			$k *= 10;
			$size += 1;
	}
	$counter += $size;
	if($counter >= $n)
	{
		last;
	}
}
$temp *= $temp;
while($counter > $n)
{
	$temp = int ($temp / 10);
	$counter -= 1;
}
$temp = int ($temp % 10);
print("The digit on position $n is $temp!\n");












