#!/usr/bin/php

<?php
#error_reporting(0);

$arr_lfs = array();

foreach ( glob("$argv[1]/*.php") as $config ) {
	require($config);
	$arr_lfs = array_merge_recursive( $arr_lfs, $arr );
	unset($arr);
}

$package = explode( '.', $argv[2], 3 );

// Находим все пакеты главы, книги
if ( $package[2] == 'all' ) {
	foreach ( $arr_lfs as $name => &$package_arr ) {
		// Проверяем не отключен ли пакет
		if ( isset($package_arr[$package[0]]) && $package_arr['status'] != 0 ) {
			// Проверка главы пакета
			$packages_id = explode( ';', $package_arr[$package[0]] );
			foreach ( $packages_id as $package_id ) {
				if ( $package_id == $package[1] ) {
					echo $name . "\n";
				};
			};
		};
	};
	exit (0);
};

// Находим пакет главы, книги
$package_arr = &$arr_lfs[$package[2]];

// Если не нашли пакет
if ( count($package_arr) <= 0 ) {
	exit ('Пакет ' . $argv[2] . ' не найден!' . "\n");
};

// Проверяем не отключен ли пакет
if ( $package_arr['status'] == 0 ) {
	exit ('Пакет ' . $argv[2] . ' отключён!' . "\n");	
};

// Проверка главы пакета
$packages_id = explode( ';', $package_arr[$package[0]] );
foreach ( $packages_id as $package_id ) {
	if ( $package_id == $package[1] ) {
		foreach ( $package_arr as $key => $value ) {
			echo $key . '=' . $value . "\n";
		};
		exit (0);
	};
};

exit ('Пакет ' . $argv[2] . ' не найден в указанной главе книги!' . "\n");

?>
