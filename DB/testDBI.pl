#!/usr/bin/perl -w
use strict; 
use Switch;
use DBI;

#malko promenliwki
my $exit = 0; #krai na cikyla za wywezhdane na nowi studenti
my $dbname = "events"; #ime na bazata danni 
my $user = "plamen"; #username - a
my $pass = "123456"; #parola za username - a
my $sth; #statement - a 
my $choice; #za osnownoto menu
my $removeCriteria; #poleto, po koeto iskame da mahame studenti
my $remove;#stojnostta na poleto
my $flag = 0;
my @criteria = ('firstname', 'secondname', 'thirdname', 'facultynumber', 'year', 'grade');
my $deleted; #iztritite studenti
my $update; #nowata stojnost na poleto, koeto update - wame
my $updateCriteria; #kriteriq, po kojto update - wame
my $prev; #starata stojnost na poleto, koeto update-wame
my $updated = 0; #broqt na promenenite studenti

# swyrzwane
my $dbh = DBI->connect("DBI:Pg:dbname=$dbname;host=localhost", $user, $pass, {'PrintError' => 1})
|| die "Couldn't connect to $dbname!\n";

#osnownoto menu
do
{
	$choice = menu();
	switch($choice)
	{
		case 1
		{
			print "-------------Information!-------------\n";
			showStudents();
		}
		case 2
		{
			print "-------------Add new students-------------\n";
			addStudents();
		}
		case 3
		{
			print "-------------Remove some students-------------\n";
			removeStudents();
		}
		case 4
		{
			print "-------------Update student information-------------\n";
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

#krai
$dbh->disconnect();

sub menu()
{
	my $val;
	do
	{
		print "+================MENU===============+\n";
		print "|1.Show information about students  |\n";
		print "|2.Add information about students   |\n";
		print "|3.Remove information about students|\n";
		print "|4.Update information about students|\n";
		print "|5.Exit                             |\n";
		print "+===================================+\n";
		print "Choose an option: ";
		$val = <STDIN>;
		chomp $val;
	}
	while($val < 1 || $val > 5);
	return $val;
}

sub showStudents
{
	$sth = $dbh->prepare("SELECT firstname, secondname, familyname, facultynumber, year, grade FROM students");
	$sth->execute();
	while(my $ref = $sth->fetchrow_hashref()) 
	{
		print "$ref->{'firstname'} $ref->{'secondname'} $ref->{'familyname'} $ref->{'facultynumber'} for $ref->{'year'} year with grade: $ref->{'grade'}\n";
	}
	$sth->finish;
	print "\n\n";
}

sub addStudents
{
	$sth = $dbh->prepare("INSERT INTO students (firstname, secondname, familyname, facultynumber, year, grade) VALUES (?, ?, ?, ?, ?, ?)")
|| die "Can't prepare!\n";
	while($exit == 0)
	{
		my ($first, $second, $third, $num, $year, $mark);
		#wywezhdane na dannite za student
		do
		{
			print "First name: ";
			$first = <STDIN>;
			chomp($first);
		}
		while($first eq '');
		do
		{
			print "Second name: ";
			$second = <STDIN>;
			chomp($second);
		}
		while($second eq '');
		do
		{
			print "Third name: ";
			$third = <STDIN>;
			chomp($third);
		}
		while($third eq '');
		do
		{
			print "Faculty number: ";
			$num = <STDIN>;
			chomp($num);
		}
		while(length($num) != 9 && $num =~ /^\d+$/);
		do
		{
			print "Year: ";
			$year = <STDIN>;
			chomp($year);
		}
		while(length($year) != 1 && $year =~ /^\d+$/);

		print "Grade: ";
		$mark = <STDIN>;
		chomp($num);
		#krai na wywezhdaneto 

		$sth->execute($first, $second, $third, $num, $year, $mark);

		if(checkAns() eq 'n')
		{
			$exit = 1;
		}
	}
	$sth->finish;
	print "\n\n";
}

sub removeStudents
{
	do
	{
		print "Enter the criteria:\nfirstname, secondname, thirdname, facultynumber, year or grade!\n";
		$removeCriteria = <STDIN>;
		chomp($removeCriteria);
		foreach my $crit (@criteria)
		{
			if($crit eq $removeCriteria)
			{
				$flag = 1;
			}
		} 
	}
	while($flag == 0);

	print "What is the $removeCriteria of the student you want to remove? ";
	$remove = <STDIN>;
	chomp($remove);
	$deleted = $dbh->do("DELETE FROM students WHERE $removeCriteria = '$remove'");
	print "There are $deleted deleted students!\n";
	print "\n\n";
}

sub updateInfo
{
	$flag = 0;
	do
	{
		print "Enter the criteria:\nfirstname, secondname, thirdname, facultynumber, year or grade!\n";
		$updateCriteria = <STDIN>;
		chomp($updateCriteria);
		foreach my $crit (@criteria)
		{
			if($crit eq $updateCriteria)
			{
				$flag = 1;
			}
		} 
	}
	while($flag == 0);

	print "What is the previous $updateCriteria of the student you want to update? ";
	$prev = <STDIN>;
	chomp($prev);
	print "What is the new $updateCriteria of the student you want to update? ";
	$update = <STDIN>;
	chomp($update);
	$updated = $dbh->do("UPDATE students SET $updateCriteria = '$update' WHERE $updateCriteria = '$prev'");
	print "There are $updated updated students!\n";
	print "\n\n";
}


sub checkAns
{
	my $ans;
	do
	{
		print "Do you want to add new student?[y/n]: ";
		$ans = <STDIN>;
		chomp($ans);
		$ans = lc($ans);
	}
	while($ans ne 'y' && $ans ne 'n');
	return $ans;
}