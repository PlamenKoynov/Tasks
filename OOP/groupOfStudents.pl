#!usr/bin/perl -w
use strict;
use Students;
use Switch;

my @group;
my $size = 0;
my $flag = 0;
my $i = 0;
my $first;
my $second;
my $last;
my $num;
my $year;
my $grade;
my $choice;

do
{
	$choice = menu();
	switch($choice)
	{
		case 1
		{
			print "-------------Create group-------------\n";
			createGroup();
		}
		case 2
		{
			print "-------------Show information for group-------------\n";
			showInformation();
		}
		case 3
		{
			print "-------------Show information-------------\n";
			showStudent();
		}
		case 4
		{
			print "-------------Change student information-------------\n";
			updateInfo();
		}
		case 5
		{
			print "-------------Exit!-------------\n";
			print "Bye bye and have a good day!\n";
			print "--------------------------------\n";
		}
	}
}
while($choice != 5);



sub menu()
{
	my $val;
	do
	{
		print "+================MENU===============+\n";
		print "|1.Create new group                 |\n";
		print "|2.Show information for group       |\n";
		print "|3.Show information for a student   |\n";
		print "|4.Change informataion for a student|\n";
		print "|5.Exit                             |\n";
		print "+===================================+\n";
		print "Choose an option: ";
		$val = <STDIN>;
		chomp $val;
	}
	while($val < 1 || $val > 5);
	return $val;
}

sub createGroup()
{
	print "Caution! You are going to create a new group and delete the old one!\n";
	do
	{
		if($flag == 0)
		{
			$flag = 1;
		}
		else
		{
			print "Wrong number of size: $size. It must be value between 1 and 29!\n";
		}
		print "How big is your group: ";
		$size = <STDIN>;
		chomp($size);
	}
	while($size < 0 || $size > 30);

	for($i = 0; $i <= $size - 1; $i++)
	{
		print "Enter data for student number: " . ($i + 1) . "\n";
		do
		{
			print "First name: ";
			$first = <STDIN>;
			chomp($first);
		}
		while(not defined $first);
		do
		{
			print "Second name: ";
			$second = <STDIN>;
			chomp($second);
		}
		while(not defined $second);
		do
		{
			print "Family name: ";
			$last = <STDIN>;
			chomp($last);
		}
		while(not defined $last);
		do
		{
			print "Faculty number: ";
			$num = <STDIN>;
			chomp($num);
		}
		while(not defined $num or length($num) != 9);
		do
		{
			print "Year: ";
			$year = <STDIN>;
			chomp($year);
		}
		while(not defined $year or $year < 0 or $year > 4);
		do
		{
			print "Grade: ";
			$grade = <STDIN>;
			chomp($grade);
		}
		while(not defined $grade or $grade < 2 or $grade > 6);
		$group[$i] = Students->new($first, $second, $last, $num, $year, $grade);
	}
	$flag = 0;
}

sub showInformation()
{
	if($size == 0)
	{
		print "There are no students to show!\n";
	}
	else
	{
		for($i = 0; $i <= $size - 1; $i++)
		{
			$group[$i]->showInfo();
		}
	}
}

sub showStudent()
{
	if($size == 0)
	{
		print "There are no students to show!\n";
	}
	else
	{
		my $pass = 0;
		my $searchNumber;
		print "Enter the faculty number of the person you are searching: ";
		$searchNumber = <STDIN>;
		chomp($searchNumber);
		for($i = 0; $i <= $size - 1; $i++)
		{
			if($group[$i]->{number} == $searchNumber)
			{
				$group[$i]->showInfo();
				$pass = 1;
				last;
			}
		}
		if($pass == 0)
		{
			print "There is no student with faculty number $searchNumber!\n";
		}
	}
}

sub updateInfo()
{
	if($size == 0)
	{
		print "There are no students to show!\n";
	}
	else
	{
		my $index = 0;
		my $pass = 0;
		my $searchNumber;
		print "Enter the faculty number of the person you are searching: ";
		$searchNumber = <STDIN>;
		chomp($searchNumber);
		for($i = 0; $i <= $size - 1; $i++)
		{
			if($group[$i]->{number} == $searchNumber)
			{
				$index = $i;
				$pass = 1;
				last;
			}
		}
		if($pass == 0)
		{
			print "There is no student with faculty number $searchNumber!\n";
		}
		else
		{
			print "Enter data for student number: " . ($i + 1) . "\n";
			do
			{
				print "First name: ";
				$first = <STDIN>;
				chomp($first);
			}
			while(not defined $first);
			do
			{
				print "Second name: ";
				$second = <STDIN>;
				chomp($second);
			}
			while(not defined $second);
			do
			{
				print "Family name: ";
				$last = <STDIN>;
				chomp($last);
			}
			while(not defined $last);
			do
			{
				print "Faculty number: ";
				$num = <STDIN>;
				chomp($num);
			}
			while(not defined $num or length($num) != 9);
			do
			{
				print "Year: ";
				$year = <STDIN>;
				chomp($year);
			}
			while(not defined $year or $year < 0 or $year > 4);
			do
			{
				print "Grade: ";
				$grade = <STDIN>;
				chomp($grade);
			}
			while(not defined $grade or $grade < 2 or $grade > 6);			
			$group[$index]->changeFirstName($first);
			$group[$index]->changeSecondName($second);
			$group[$index]->changeFamilyName($last);
			$group[$index]->changeFacultyNumber($num);
			$group[$index]->changeYear($year);
			$group[$index]->changeGrade($grade);
		}
	}
}