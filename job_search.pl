#!/usr/bin/perl
use strict;
use warnings;


sub open_default_browser {
	my $url = shift;
	my $platform = $^O;
	my $cmd;
	if    ($platform eq 'darwin')  { $cmd = "open \"$url\"";          } # Mac OS X
	elsif ($platform eq 'linux')   { $cmd = "x-www-browser \"$url\""; } # Linux
	elsif ($platform eq 'MSWin32') { $cmd = "start $url";             } # Win95..Win7
	if (defined $cmd) {
    	system($cmd);
  	} else {
    	die "Can't locate default browser";
  	}
}

my @keywords = ("big data", "data analyst", "data scientist", "machine learning", "deep learning", "quantitative analyst", "risk analyst",
"matematica", "mathematics", "physics", "phd", "dottorato", "mathematica", "python", "actuarial", "R sas", "tensorflow", "scikit-learn", "perl", "statistica",
"statistics", "R python", "data mining");

my @locations = ("roma");

my $basic_url = "https://it.indeed.com/offerte-lavoro\?";
my $query = "q\=";
my $loc = "\&l\=";
my $end_url = "\&fromage\=last";

	

foreach my $key (@keywords)
{
foreach my $location (@locations)
{
	my @kwds = split ' ', $key;
	
	my $my_query = $query;
	foreach my $k (@kwds)
	{
		$my_query = $my_query.$k."+"; 
	}
	chop($my_query);
	
	my $url = $basic_url.$my_query.$loc.$location.$end_url;

	open_default_browser($url);
}
}


### end of code
print "\nEND OF CODE\n";
