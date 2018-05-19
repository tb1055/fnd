#!/usr/bin/perl
use strict;
use File::Find;

my $searchword = "";
my $searchfile = "";
my $searchroot = "";
my @searchrootArr = "";

my $counter = 0;

# Use loop to print all args stored in an array called @ARGV
foreach my $a(@ARGV) {
	#print "Arg # $counter : $a\n";
	$counter++;
}

if ($counter == 0) {
   &helptext;
   exit;
   }

if ($ARGV[0] eq '-w') {
   $searchword = $ARGV[1];
   }
elsif ($ARGV[0] eq '-f') {
   $searchfile = $ARGV[1];
   }
elsif ($ARGV[0] eq '-f') {
   $searchfile = $ARGV[1];
   }
elsif ($ARGV[0] eq '-r') {
   $searchroot = $ARGV[1];
   $searchrootArr[0] = $searchroot;
   }


if ($ARGV[2] eq '-w') {
   $searchword = $ARGV[3];
   }
elsif ($ARGV[2] eq '-f') {
   $searchfile = $ARGV[3];
   }
elsif ($ARGV[2] eq '-r') {
   $searchroot = $ARGV[3];
   $searchrootArr[0] = $searchroot;
   }


if ($ARGV[4] eq '-w') {
   $searchword = $ARGV[5];
   }
elsif ($ARGV[4] eq '-f') {
   $searchfile = $ARGV[5];
   }
elsif ($ARGV[4] eq '-r') {
   $searchroot = $ARGV[5];
   $searchrootArr[0] = $searchroot;
   }


printf "searchword = [$searchword]\n";
printf "searchfile = [$searchfile]\n";
printf "searchroot = [$searchroot] array0 [$searchrootArr[0]]\n";

printf "Hit Enter > "; scalar <STDIN>;

#--------------------------------------------------------
# Subroutine: process_file
#--------------------------------------------------------
sub process_file {
   my $fullpath = $File::Find::name;         # Get full path
   my @fullpathArr = split('/', $fullpath);  # Split into subfolder array
   my $bit = $#fullpathArr;                  # Get count of subfolders
   
   my $fname = $fullpathArr[$bit];

   
   if ($searchfile ne "" && $fname =~ /$searchfile/i) {
      printf "FOUND FILE!! $fname $fullpath\n";
      printf "FullPath  $fullpath\n";
      printf "FileName  $fname\n";
      if ($searchword ne "") { &grepfile($fullpath, $searchword); }
      }
   elsif ($searchfile eq "") {
      #printf "FullPath  $fullpath\n";
      #printf "FileName  $fname\n";
      if ($searchword ne "") { &grepfile($fullpath, $searchword); }
      }   
   #printf "\n";
   
   }

printf "\n";
find(\&process_file, $searchrootArr[0]);

#--------------------------------------------------------
# Subroutine: grepfile  monkey
#--------------------------------------------------------
sub grepfile
{
my $endpoint = shift;
my $searchkey = shift;

my $thisLine;
my $linecnt = 0;

open (FILE, $endpoint) || die("Could not open $endpoint\n");
while (<FILE>) {
   $thisLine = $_;
   chop $thisLine;
   $linecnt++;
      
   if ($thisLine =~ $searchkey) {
      printf "FOUND WORD at line $linecnt !! $searchkey $endpoint\n";
      printf "$thisLine\n";

      #printf "Hit Enter > "; scalar <STDIN>;
      }
   }   

}


#--------------------------------------------------------
# Subroutine: helptext  monkey
#--------------------------------------------------------
sub helptext
{

printf "Syntax:\n";
printf "fnd.pl -w word -f filename -r searchroot\n";

printf "\nExamples:\n";

printf "fnd.pl -w utah  -r ~/Documents\n";
printf "fnd.pl -w ethereum -r /apps\n";


printf "\n";

}
