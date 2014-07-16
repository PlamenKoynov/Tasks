#!/usr/bin/perl -w
use strict;

my $exit = 0;
my $size = 1;
my $counter = 0;
my $n;
my $k = 10;
my $num = 1;

do
{
	print "Position: \n";
	$n = <STDIN>;
	chomp($n);
}
while($n <= 0 || $n > 3200000);

while($exit == 0)
{
	if($counter >= $n)
	{
		$exit = 1;
		$num -= 1
	}
	else
	{
		if($num * $num > $k)
		{
			$k *= 10;
			$size += 1;
		}
		$counter += $size;
		$num += 1;
	}
}
$num *= $num;
while($counter > $n)
{
	$num = int ($num / 10);
	$counter -= 1;
}
$num = int ($num % 10);
print("The digit on position $n is $num!\n");
