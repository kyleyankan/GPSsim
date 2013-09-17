#!/usr/bin/perl -w
#39.9507, -75.1347 Philly

use GPS::Point;


$point = GPS::Point->new(lat=> 39.9507, lon=> -75.1347, speed => 0);

print scalar($point->lat), "," , scalar($point->long), "\n";


foreach my $i (0..1000) {
	$time = 5.0; #in seconds
	$direction = 180+ rand(45); #moving south then westward
	$speed = 2; #knots - 1,852 meters in a nautical mile

	#above is where I'd get the time, speed, and direction
	$distance = (($speed*1852) / (60*60)* $time);

	$point = $point->forward($distance =>$direction); 
	print scalar($point->lat), "," , scalar($point->long), "\n";


	#print scalar($point->toString), "\n";
	#try to create NMEA Sentence
	#if ($point->lat > 0) {$latdir = "N";} else {$latdir="S";}
        #if ($point->long > 0) {$londir = "E";} else {$londir="W";}
	#$nmeaString = "GPGLL," .scalar( abs($point->lat *100)) . ",$latdir,";
	#$nmeaString .= scalar(abs($point->long *100)) . ",$londir,";	
	#$checksum ^= ord($nmeaString);
	#print "\$" . $nmeaString . "*";
	#print $checksum;
	#print "\n";


#	sleep $time;
}
