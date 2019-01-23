#!/usr/bin/env perl

# EpochConverter.com examples

use strict;
use warnings;
use Time::Local qw(timelocal);
use Date::Parse qw(str2time);


my $epoch = time; # epoch in seconds

my @normaldate = showDateString($epoch);
print "It is now: ".$epoch." this converts to: ".outputDateString(@normaldate)."\n";

$normaldate[5] += 10; # add 10 years
print "In 10 years the epoch will be: ".convertToEpoch(@normaldate)."\n";


print "Convert 1 dec 2020 to epoch: "
  . str2time("12/01/2020 11:50AM")." or "  # MDY
  . str2time("2020-12-01 11:50AM")."\n";   # YMD


sub showDateString {
  my $timestamp = shift;
  my ($sec, $min, $hour, $day, $month, $year) = (localtime($timestamp))[0,1,2,3,4,5];
  # replace localtime with gmtime for GMT/UTC
  return ($sec, $min, $hour, $day, $month, $year);
}

sub outputDateString {
  my ($sec, $min, $hour, $day, $month, $year) = @_;
  my @months = ("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");  # months array starts at 0!
  return $months[$month]." ".$day.", ".($year+1900)." ".sprintf("%02d",$hour).":".sprintf("%02d", $min).":".sprintf("%02d",$sec);
}

sub convertToEpoch {
  my @datestring = @_;
  return timelocal(@datestring); # replace timelocal with 'timegm' for GMT/UTC
}


=begin comment

# using DateTime, not installed by default on Ubuntu
use DateTime;
use DateTime::Format::ISO8601;

my $dt = DateTime->new( year => 2020, month => 11, day => 30, hour => 13, minute => 30, second => 0, nanosecond => 500000000, time_zone => 'Europe/Paris' );
my $epoch_time  = $dt->epoch;
print $epoch_time."\n";

use DateTime;

my $inputDate = "2020-10-30T23:00:00.000Z";
my $dt = DateTime::Format::ISO8601->parse_datetime($inputDate);
print  $dt->strftime("%s")."\n";

=end comment


1;
