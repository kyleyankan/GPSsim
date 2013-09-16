#!/usr/bin/perl -w
#39.9507, -75.1347 Philly

use GPS::Point;


$point = GPS::Point->new(lat=> 39.9507, lon=> -75.1347, speed => 0);

print scalar($point->latlon), "\n";


while (1) {
	$time = 60;
	$direction = 180;
	$speed = 22; #knots - 1,852 meters in a nautical mile

	#above is where I'd get the time, speed, and direction
	$distance = ($speed*1852) / $time;

	$point = $point->forward($distance =>$direction); 

	print scalar($point->latlon), "\n";
	sleep $time;
}
