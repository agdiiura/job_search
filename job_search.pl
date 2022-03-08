#!/usr/bin/perl

use strict ;
use warnings ;
use Pod::Usage ;
use Getopt::Long ;
use File::Slurp ;

#use Browser::Open qw( open_browser );

=pod

=head1 DESCRIPTION

	A script for job searching using the indeed engine.

	* verbose: (flag) option for verbose
	* keys: (str) query keys configuration file, default 'keys.conf'
	* locations: (str) query locations configuration file, default 'locations.conf'

    examples:
    $ perl job_search.pl
    $ perl job_search.pl --verbose

=cut

my $verbose        = 0 ;
my $keys_file      = "keys.conf" ;
my $locations_file = "locations.conf" ;

GetOptions(
    "f|verbose!"      => \$verbose,
    "keys=s"          => \$keys_file,
    "keyslocations=s" => \$locations_file,
    )
    or pod2usage( "Try '$0 --help' for more information." ) ;

# TODO: fix open in WSL!!!

sub open_default_browser {
    my $url      = shift ;
    my $platform = $^O ;

    my $cmd ;

    if ( $platform eq 'darwin' ) {
        $cmd = "open \"$url\"" ;    # Mac OS X
    } elsif ( $platform eq 'linux' ) {
        $cmd = "x-www-browser \"$url\"" ;    # Linux
    } elsif ( $platform eq 'MSWin32' ) {
        $cmd = "start $url" ;                # Win95..Win7
        }

    if ( defined $cmd ) {
        system( $cmd) ;
    } else {
        die "Can't locate default browser $!" ;
        }
    }

# load external files
my @keywords  = read_file( $keys_file,      chomp => 1 ) ;
my @locations = read_file( $locations_file, chomp => 1 ) ;

my $basic_url = "https://it.indeed.com/offerte-lavoro\?" ;
my $query     = "q\=" ;
my $loc       = "\&l\=" ;
my $end_url   = "\&fromage\=last" ;

sub main {
    foreach my $key ( @keywords ) {
        foreach my $location ( @locations ) {
            my @kwds = split ' ', $key ;

            my $my_query = $query ;
            foreach my $k ( @kwds ) {
                $my_query = $my_query . $k . "+" ;
                }
            chop( $my_query ) ;

            my $url = $basic_url . $my_query . $loc . $location . $end_url ;

            if ( $verbose > 0 ) {
                print $url. "\n" ;
                }
            open_default_browser( $url ) ;
            }
        }

    }

### end of code
main() ;
print "\nEND OF CODE\n" ;
