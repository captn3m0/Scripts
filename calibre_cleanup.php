#!/usr/bin/php
<?php
$directory = '/home/nemo/.gvfs/Nemo%27s iPad/Books/Purchases/';
$it = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($directory));
while($it->valid()){
	if (!$it->isDot()){
		$filename = $it->key();
		if(substr($filename,-6)=='.xhtml'){
			echo $filename."\n";
			$f = file($filename);
			if(count($f)>10){
				if(strpos($f[10],"@namespace")!==false){
					$f[10]="<div>\n";
					$contents = join("",$f);
					file_put_contents($filename,$contents);
					echo "Updated\n";
				}
			}
		}
	}
	$it->next();
}
