#!usr/bin/perl -w
use strict;
use Switch;

package Students;

sub new()
{
	my $class = shift;
	my $self = {
			first	=> shift,
			second 	=> shift,
			third 	=> shift,
			number	=> shift,
			year	=> shift,
			grade  	=> shift
	};
	bless $self, $class;
	return $self;
}

sub showInfo()
{
	my ($self) = @_;
	print "Information about student!\n";
	print "First name: $self->{'first'}\n"; 
	print "Second name: $self->{'second'}\n";
	print "Third name: $self->{'third'}\n";
	print "Faculty number: $self->{'number'}\n";
	print "Year: $self->{'year'}\n";
	print "Grade: $self->{'grade'}\n";
}

sub showWholeName
{
	my($self) = @_;
	return $self->{'first'} . " " . $self->{'second'} . " " . $self->{'third'};
}

sub changeFirstName
{
	my($self, $name) = @_;
	if(defined $name and $name ne "")
	{
		$self->{first} = $name;
	}
	return $self->{first};
}

sub changeSecondName
{
	my($self, $name) = @_;
	if(defined $name and $name ne "")
	{
		$self->{second} = $name;
	}
	return $self->{second};
}

sub changeFamilyName
{
	my($self, $name) = @_;
	if(defined $name and $name ne "")
	{
		$self->{third} = $name;
	}
	return $self->{third};
}

sub changeFacultyNumber
{
	my($self, $num) = @_;
	if(defined $num and length($num) == 9)
	{
		$self->{number} = $num;
	}
	return $self->{number};
}

sub changeYear
{
	my($self, $currYear) = @_;
	if(defined $currYear and $currYear > 0 and $currYear <= 4)
	{
		$self->{year} = $currYear;
	}
	return $self->{year};
}

sub changeGrade
{
	my($self, $gr) = @_;
	if(defined $gr and $gr >= 2 and $gr <= 6)
	{
		$self->{grade} = $gr;
	}
	return $self->{grade};
}
sub oldDogs
{
	my ($self) = @_;
	switch($self->{year})
	{
		case 1
		{
			print "You are fresh fishy, fishy!\n";
		}
		case 2
		{
			print "You are not so fresh, but still fishy, fishy!\n";
		}
		case 3
		{
			print "You are almost old dog!\n";
		}
		case 4
		{
			print "If you are still alive, you are champion!!!\n";
		}
	}	
}
1;