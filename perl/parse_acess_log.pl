#!/usr/bin/perl -w 

$LOGFILE = "/var/log/httpd/access_log";
open(LOGFILE) or die ("Couldn't open file");

foreach $line (<LOGFILE>) {
	@log = ($origin, $name, $longName, $date, $gmt, $requisition, 
		$item, $protocol, $status, $length) = split(' ', $line);
	print(@log, "\n");
#	print($item, "\n");
}

close(LOGFILE);
