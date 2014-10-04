#!/usr/bin/php

<?php
// Моздание массива переменных
$arr_lfs = array();

// Перебераем кончиги с масивами
foreach ( glob("$argv[1]/*.php") as $config ) {
	// Загружаем массив из конфига
	require($config);
	// Обьеденяем массив с основным
	$arr_lfs = array_merge_recursive( $arr_lfs, $arr );
	// Удоляем временный массив
	unset($arr);
}

// Разбираем BOOK.CHAPTER.PACKAGE
$package = explode( '.', $argv[2], 3 );

$BOOK = $package[0];
$CHAPTER = $package[1];
$NAME = $package[2];

// Все пакеты главы, книги
if ( $NAME == 'all' ) {
	// Перебераем пакеты
	foreach ( $arr_lfs as $name => &$package_arr ) {
		// Проверяем не отключен ли пакет
		if ( isset($package_arr[$BOOK]) && $package_arr['status'] != 0 ) {
			// Проверка главы пакета
			$packages_id = explode( ';', $package_arr[$BOOK] );
			foreach ( $packages_id as $package_id ) {
				if ( $package_id == $CHAPTER ) {
					echo $name . "\n";
				};
			};
		};
	};
	exit (0);
};

// Находим пакет
$package_arr = &$arr_lfs[$NAME];

// Если не нашли пакет
if ( count($package_arr) <= 0 ) {
	exit ('Пакет ' . $argv[2] . ' не найден!' . "\n");
};

// Проверяем не отключен ли пакет
if ( $package_arr['status'] == 0 ) {
	exit ('Пакет ' . $argv[2] . ' отключён!' . "\n");	
};

// Проверка главы пакета
$packages_id = explode( ';', $package_arr[$BOOK] );
foreach ( $packages_id as $package_id ) {
	if ( $package_id == $CHAPTER ) {
		foreach ( $package_arr as $key => $value ) {
			echo $key . '=' . $value . "\n";
		};
		exit (0);
	};
};

exit ('Пакет ' . $argv[2] . ' не найден в указанной главе книги!' . "\n");

?>
