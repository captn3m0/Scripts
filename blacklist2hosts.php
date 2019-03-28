#!/usr/bin/php
<?php

$filename= $argv[1];
$outputfile = $argv[2];
$f = fopen($outputfile, 'w');

foreach(file($filename) as $row) {
	if (strlen(trim($row)) > 0 and trim($row)[0] != "#") {
		fwrite($f, trim($row) . ' 0.0.0.0' . PHP_EOL);
	}
}

fclose($f);