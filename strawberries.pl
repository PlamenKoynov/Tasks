#!usr/bin/perl
use strict;

my @strawberries = ();
my $rows;
my $cols;
my $days;
my $i = 0;
my $j = 0;
my $d = 0;
my $counter = 2;
my $x;
my $y;
my $countStrawberries;

do
{
	print "Size x: ";
	$x = <STDIN>;
	chomp($x);
}
while($x <= 0 || $x > 1000 || $x =~ /\D/);

do
{
	print "Size y: ";
	$y = <STDIN>;
	chomp($y);
}
while($y <= 0 || $y > 1000 || $y =~ /\D/);
do
{
	print "Days: ";
	$days = <STDIN>;
	chomp($days);
}
while($days < 0 || $days > 100 || $days =~ /\D/);
do
{
	print "Bad strawberries: ";
	$countStrawberries = <STDIN>;
	chomp($countStrawberries);
}
while($countStrawberries > $x * $y || $countStrawberries < 0 || $countStrawberries =~ /\D/);

for($i = 1; $i <= $x; $i++)
{
	for($j = 1; $j <= $y; $j++)
	{
		$strawberries[$i][$j] = 0;
	}
}


for($i = 0; $i <= $countStrawberries - 1; $i++)
{
	do
	{
		print "Row: ";
		$rows = <STDIN>;
		chomp($rows);
	}
	while ($rows < 0 || $rows > $x); 
	do
	{
		print "Column: ";
		$cols = <STDIN>;
		chomp($cols);
	}
	while ($cols < 0 || $cols > $y);
	$strawberries[$x - $rows + 1][$cols] = 1;
}

for($d = 1; $d <= $days; $d++)
{
	for($i = 1; $i <= $x; $i++)
	{
		for($j = 1; $j <= $y; $j++)
	  	{
	  		if($strawberries[$i][$j] == $d)
	  		{
	  			if($i + 1 <= $x && $strawberries[$i + 1][$j] == 0)
	  			{
	  				$strawberries[$i + 1][$j] = $counter;
	  			}
	  			if($i - 1 >= 0 && $strawberries[$i - 1][$j] == 0)
	  			{
	  				$strawberries[$i - 1][$j] = $counter;
	  			}
	  			if($j + 1 <= $y && $strawberries[$i][$j + 1] == 0)
	  			{
	  				$strawberries[$i][$j + 1] = $counter;
	  			}
	  			if($j - 1 >= 0 && $strawberries[$i][$j - 1] == 0)
	  			{
	  				$strawberries[$i][$j - 1] = $counter;
	  			}
	  		}
	  	}
	}
	$counter++;
}

$counter = 0;
for($i = 1; $i <= $x; $i++)
{
	for($j = 1; $j <= $y; $j++)
	{
		if($strawberries[$i][$j] == 0)
	  	{
	  		$counter++;
	  	}
	}
}

print "Good strawberries: $counter!\n";
