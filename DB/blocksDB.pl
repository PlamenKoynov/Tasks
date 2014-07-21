#!/usr/bin/perl -w
use strict; 
use Switch;
use DBI;

#malko promenliwki
my $exit = 0; #krai na cikyla za wywezhdane na nowi blokowe
my $dbname = "events"; #ime na bazata danni 
my $user = "plamen"; #username - a
my $pass = "123456"; #parola za username - a
my $sth; #statement - a 
my $choice; #za osnownoto menu
my $removeCriteria; #poleto, po koeto iskame da mahame blokowe
my $remove;#stojnostta na poleto
my $flag = 0;
my $deleted; #iztritite blokowe
my $update; #nowata stojnost na poleto, koeto update - wame
my $updateCriteria; #kriteriq, po kojto update - wame
my $prev; #starata stojnost na poleto, koeto update-wame
my $updated = 0; #broqt na promenenite blokowe
my $ans; 
my @criteria = ('blockname', 'address', 'manager', 'contcts');
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
			showBlocks();
		}
		case 2
		{
			print "-------------Add new blocks-------------\n";
			addBlocks();
		}
		case 3
		{
			print "-------------Remove some blocks-------------\n";
			removeBlocks();
		}
		case 4
		{
			print "-------------Update block information-------------\n";
			updateInfo();
		}
		case 5
		{
			print "-------------Read data from file-------------\n";
			readFromFile();	
		}
		case 6
		{
			print "-------------Exit!-------------\n";
			print "Bye bye and have a good day!\n";
			print "--------------------------------\n";
		}
	}
}
while($choice != 6);

#krai
$dbh->disconnect();

sub menu
{
	my $val;
	do
	{
		print "+================MENU===============+\n";
		print "|1.Show information about blocks    |\n";
		print "|2.Add information about block      |\n";
		print "|3.Remove information about block   |\n";
		print "|4.Update information about block   |\n";
		print "|5.Add blocks from file             |\n";
		print "|6.Exit                             |\n";
		print "+===================================+\n";
		print "Choose an option: ";
		$val = <STDIN>;
		chomp $val;
	}
	while($val < 1 || $val > 6);
	return $val;
}

sub showBlocks
{
	my $flag = 0;
	$sth = $dbh->prepare("SELECT * FROM blocks");
	$sth->execute();
	while(my $ref = $sth->fetchrow_hashref()) 
	{
		$flag = 1;
		print "$ref->{'blockname'} $ref->{'address'} $ref->{'manager'} $ref->{'contcts'}\n";
	}
	if($flag == 0)
	{
		print "There are no blocks to show!\n";
	}
	$sth->finish;
	print "\n\n";
}

sub addBlocks
{
	$exit = 0;
	while($exit == 0)
	{
		my ($name, $address, $manager, $contacts);
		#wywezhdane na dannite za student
		do
		{
			print "Name: ";
			$name = <STDIN>;
			chomp($name);
		}
		while($name eq '');
		do
		{
			print "Address: ";
			$address = <STDIN>;
			chomp($address);
		}
		while($address eq '');
		do
		{
			print "Manager: ";
			$manager = <STDIN>;
			chomp($manager);
		}
		while($manager eq '');
		do
		{
			print "Contact: ";
			$contacts = <STDIN>;
			chomp($contacts);
		}
		while(length($contacts) != 10);

		$dbh->do("INSERT INTO blocks (blockname, address, manager, contcts) VALUES (\'$name\', \'$address\', \'$manager\', \'$contacts\')");

		if(checkAns() eq 'n')
		{
			$exit = 1;
		}
	}
	print "\n\n";
}

sub removeBlocks
{
	do
	{
		print "Enter the criteria:\nname, address, manager, contcts\n";
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

	print "What is the $removeCriteria of the block you want to remove? ";
	$remove = <STDIN>;
	chomp($remove);
	$deleted = $dbh->do("DELETE FROM blocks WHERE $removeCriteria = '$remove'");
	print "There are $deleted deleted blocks!\n";
	print "\n\n";
}

sub updateInfo
{
	$flag = 0;
	do
	{
		print "Enter the criteria:\nname, address, manager, contcts!\n";
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

	print "What is the previous $updateCriteria of the block you want to update? ";
	$prev = <STDIN>;
	chomp($prev);
	print "What is the new $updateCriteria of the block you want to update? ";
	$update = <STDIN>;
	chomp($update);
	$updated = $dbh->do("UPDATE blocks SET $updateCriteria = '$update' WHERE $updateCriteria = '$prev'");
	print "There are $updated updated blocks!\n";
	print "\n\n";
}

sub readFromFile
{
	my @info;
	my $filename;
	print "Please entr the name of the file you want to open for reading!\n";
	$filename = <STDIN>;
	chomp($filename);

	open FILE, "< $filename" || die "Can't open file $filename!\n";
	while(<FILE>)
	{
		@info = split / /, $_;
		$dbh->do("INSERT INTO blocks (blockname, address, manager, contcts)	VALUES (\'$info[0]\', \'$info[1]\', \'$info[2]\', \'$info[3]\')");
	}
	close FILE;
	print "The file was read!\n";
}

sub checkAns
{
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
