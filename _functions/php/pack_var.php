#!/usr/bin/php

<?php
#error_reporting(0);

function f_chapter ($book, $chapter, $pack) {
	if ( isset($pack[$book]) ) {
		$packs_id = explode(';', $pack[$book]);
		foreach ($packs_id as $pack_id) {
			if ( $pack_id == $chapter ) {
				return true;
			}
		}
	}
	return false;
}

$arr_lfs = array();

foreach (glob("$argv[1]/*.php") as $config) {
	require($config);
	$arr_lfs = array_merge_recursive($arr_lfs, $arr);
	unset($arr);
}

$package = explode( '.', $argv[2], 3 );

switch ($package[2]) {
	case 'all':
		foreach ($arr_lfs as $key => $value) {
			if ( f_chapter($package[0], $package[1], $arr_lfs[$key]) ) {
				echo $key . "\n";
			}
		}
		exit (0);
	break;
}

$package_arr = &$arr_lfs[$package[2]];

// Если не нашли пакет
if ( count($package_arr) <= 0 ) {
	exit ('Пакет ' . $argv[2] . ' не найден!' . "\n");
}

// Проверяем не отключен ли пакет
if ( $package_arr['status'] == 0 ) {
	exit ('Пакет ' . $argv[2] . ' отключён!' . "\n");	
}

// Проверка главы пакета
if ( f_chapter ($package[0], $package[1], $package_arr) ) {
	foreach ($package_arr as $key => $value) {
		echo $key . '=' . $value . "\n";
	}
} else {
	exit ('Пакет ' . $argv[2] . ' не найден в указанной главе книги!' . "\n");
}

?>
