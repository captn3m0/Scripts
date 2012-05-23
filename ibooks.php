<?php
include '../~github/CFPropertyList/CFPropertyList.php';
$plist = new CFPropertyList('/tmp/Books.plist');
$a = $plist->toArray();
$a = $a['Books'];
foreach($a as $book)
  if(substr($book['Path'],-4) == '.pdf')
	echo $book['Path']." - ".$book['Name']."\n";
