#!usr/bin/perl 
use strict;
#trqbwa da wklucha warningite!!!

my @goats;
my @transported;
my @temp; 
my $trips;
my $size;
my $temp;
my $i = 0;
my $j = 0;
my $p = 0;
my $sum = 0;
my $search;
my $mid = 0;
my $diff;
my $min;
my $flag = 0;
my $minDiff = 1000000000000;
my $all = 0;

print "Number of goats\n";
$size = <STDIN>;
chomp($size);
if($size <= 0 || $size > 1000)
{
	die "Wrong input!The number must be between 0 and 1000\n";
}

print "Number of trips\n";
$trips = <STDIN>;
chomp($trips);
if($trips <= 0 || $trips > 1000)
{
	die "Wrong input!The number must be between 0 and 1000\n"
}
for($i = 0; $i <= $size - 1; $i++)
{
	$temp = <STDIN>;
	chomp($temp);
	if($temp <= 0 && $temp > 100000)
	{
		die "Wrong input!The number must be between 0 and 100000\n";
	}
	push(@goats, $temp);
	$sum += $temp;
}

$mid = int ($sum / $trips);
@goats = sort {$b <=> $a} @goats;
$all = $sum;
$i = 0;
$sum = 0;
for($p = 0; $p <= $trips - 2; $p++)
{	
		#print $goats[$i];
		while($goats[$i] == 0)
		{	
			#print "$goats[1]\n";
			$i++;
		} 			
		$sum = $goats[$i];
		if($mid >= $sum) 			
		{
			$minDiff = $mid - $sum;
		} 
		else
		{
			$minDiff = $sum - $mid;
		}

		$goats[$i] = 0;	
		push(@temp, $sum);		

		for($j = $i + 1; $j <= $size - 1; $j++)
		{
			$sum += $goats[$j];
			#print "$sum \n";
			push(@temp, $goats[$j]);
		
			if($mid >= $sum)
			{
				$diff = $mid - $sum;
			}
			else
			{
				$diff = $sum - $mid;
				$flag = 1;
			}	
		
			if($diff < $minDiff && $flag == 0)
			{
				$minDiff = $diff;
				$goats[$j] = 0;
			}
			else
			{	
				my $check = pop(@temp);
				$sum = $sum - $check;
				$flag = 0;
			}
		}
	push(@transported, $sum);
	$sum = 0;
	@temp = ();
}
	
$min = $transported[0];
foreach my $ship (@transported)
{
	$sum += $ship;
	print "$ship \n";
	if($ship > $min)
	{
		$min = $ship;
	}
}
print "All: $all\n";
if($all - $sum > $min)
{
	$min = $all - $sum;
}
print "Min: $min\n";
