#!/usr/bin/perl

$first = 1;

print "{\n";
print "\t\"data\":[\n\n";

$ports = {};

for (`sudo netstat --tcp --listening --numeric --program | grep LISTEN`) {
  ($listenport,$procname) = m/^.*:(\d+).*\/(.*)$/;
  $procname =~ s/\s+$//; #remove trailing spaces

  next if defined($ports[$listenport]);
  $ports[$listenport] = 1;
  #print "$listenport,$procname\n";

  print "\t,\n" if not $first;
  $first = 0;

  print "\t{\n";
  print "\t\t\"{#PROCNAME}\":\"$procname\",\n";
  print "\t\t\"{#PORT}\":\"$listenport\"\n";
  print "\t}\n";
  }


print "\n\t]\n";
print "}\n";

