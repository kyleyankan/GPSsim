#!/usr/bin/perl -w
#39.9507, -75.1347 Philly

use GPS::Point;


$point = GPS::Point->new(lat=> 39.9507, lon=> -75.1347, speed => 0);

#print scalar($point->lat), "," , scalar($point->long), "\n";


foreach my $i (0..10000) {
	$time = 5; #in seconds
	$direction = 180+ (rand(90)-45); #moving south then westward
	#$direction = 180;	
	$speed = 30; #knots - 1,852 meters in a nautical mile

	#above is where I'd get the time, speed, and direction
	$distance = (($speed*1852) / (60*60)* $time);

	$point = $point->forward($distance =>$direction); 
	#print scalar($point->lat), "," , scalar($point->long), "\n";


	#print scalar($point->toString), "\n";
	#try to create NMEA Sentence
	if ($point->lat > 0) {$latdir = "N";} else {$latdir="S";}
        if ($point->long > 0) {$londir = "E";} else {$londir="W";}
	$nmeaString = "GPGLL," .scalar( abs($point->lat *100)) . ",$latdir,";
	$nmeaString .= scalar(abs($point->long *100)) . ",$londir";	
	$checksum = 0;
	for (split //, $nmeaString){
    	    $checksum ^= ord($_);
    	}
	print "\$" . $nmeaString . "*";
	print sprintf('%02X', $checksum);
	print "\r\n";
	
	updateKML($point->lat, $point->long, $i);
	
	sleep $time;
}





sub updateKML {
($lat, $lon, $i) = @_;
open(KML,">./realtime.kml");
print KML qq~<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://earth.google.com/kml/2.0">
	<Placemark>
		<name>point $i</name>
		<description>$i</description>
		<LookAt>
			<longitude>$lon</longitude>
			<latitude>$lat</latitude>
			<range>800</range>
			<tilt>60</tilt>
			<heading>180</heading>
		</LookAt>
		<Point>
			<coordinates>$lon, $lat, 0.</coordinates>
		</Point>
	</Placemark>
</kml>
~;
close KML;
}
