#!/usr/bin/perl -w

#use strict;
use Getopt::Std;
#use Switch;

getopts('p:b:c:n:a:m:d:l:', \%opts);

if (!defined $opts{'b'} || !defined $opts{'c'} || !defined $opts{'n'}) {
	die "Не указанны объязательные ключи: -b, -c и -n!\n";
}

# Объязательные переменные
my $BOOK = $opts{'b'};
my $CHAPTER = $opts{'c'};
my $NAME = $opts{'n'};
my $PATH = defined($opts{'p'}) ? $opts{'p'} : '/usr/src/clfs-script/conf';

my $book = $BOOK . '::pkg';
my @signLink = ('status', 'type', 'link', 'chapter', 'extract');
my @elemArr = ('urlpatch', 'md5patch', 'chapter', 'extract');

# Загружаем переменные
my $file = $PATH . '/' . $BOOK . '.pm';
if (-f $file) {
	require $file;
} elsif (!defined $opts{'a'} && !defined $opts{'m'} && !defined $opts{'l'}) {
	die "Файл с массивом пакетов не найден!";
} else {
	my %pkg;
	$book = \%pkg;
}

sub outElem {
	local $pkg = $_[0];
	local $elem = $_[1];

	if ($elem eq 'chapter') {
		foreach $chapter (values ${$pkg}{'chapter'}) {
			outElem($pkg, 'C' . $chapter);
		}
	}

	# Если элемента нет
	if (!defined(${$pkg}{$elem})) {
		return 0;
	}

	# Если элемент содержит массив
	if (ref(${$pkg}{$elem}) eq 'ARRAY') {
		print $elem . '=( ';
		foreach $value (values ${$pkg}{$elem}) {
			print '"' . $value . '" ';
		}
		print ")\n";
	# Если элемент переменная
	} elsif (ref(${$pkg}{$elem}) eq '') {
		print $elem . '="' . ${$pkg}{$elem} . "\"\n";
	}
}

sub pkgSkip {
	local $pkgName = $_[0];
	local $f = 1;

	# Проверка включён ли пакет
	if (!defined(${$book}{$pkgName}{'status'})) { return 1; }

	# Проверка соответствия главе
	foreach $chapter (values ${$book}{$pkgName}{'chapter'}) {
		if ($CHAPTER eq $chapter) {
			$f = 0;
		}
	}
#	if (!defined (grep /$CHAPTER/, @{${$book}{$pkgName}{'chapter'}})) { return 1; }

	return $f;
}

# Если не надо создавать, модифицировать или удолять пакет
if (!defined $opts{'a'} && !defined $opts{'m'} && !defined $opts{'d'} && !defined $opts{'l'}) {

	# Если выводим все пакеты
	if ($NAME eq 'all') {
		# перебираем все пакеты
		foreach $name (keys %{$book}) {
			# Проверка пакета
			if (pkgSkip($name)) { next; }

			# Формируем список пакетов
			if (defined(${$book}{$name}{'C' . $CHAPTER})) {
				foreach $order (values ${$book}{$name}{'C' . $CHAPTER}) {
					$outList{$order} = $BOOK . '.' . $CHAPTER . '.' . $name;
				}
			}
		}
		# Выводим список пакетов
		foreach my $key (sort {$a cmp $b} keys %outList) {
			print $key . '.' . $outList{$key} . "\n";
		}
		exit;
	}

	defined(${$book}{$NAME})
		or die "Пакет не найден!\n";

	# Проверка пакета
	if (pkgSkip($NAME)) { exit; }

	if (${$book}{$NAME}{'type'} eq 'link') {
		!defined (${$book}{${$book}{$NAME}{'link'}})
			and die 'Ссылка ' . $NAME . ' ссылается на не сушествуюший пакет ' . ${$book}{$NAME}{'link'} . "!\n";
	}

	# Выводим информацию пакета
	print 'name="' . $NAME . "\"\n";
	# Перебираем элементы
	foreach $key (keys %{$book}{$NAME}) {
		# Пропускаем порядок в главе
		if ($key =~ m/C/) { next; }

		outElem(${$book}{$NAME}, $key);
	}

	# Если пакет ссылка
	if (${$book}{$NAME}{'type'} eq 'link') {
		foreach $key (keys %{$book}{${$book}{$NAME}{'link'}}) {
			# Элементы ссылки
			if ($key =~ m/md5|url|version/) {
				outElem(${$book}{${$book}{$NAME}{'link'}}, $key);
			}
		}
	}
	exit;
}

# Шаблоны проверки значений элементов
sub template {
	local $type = $_[0];

	if ($type eq 'url' || $type eq 'urlpatch') {
		return 'http:|https:|ftp:|git:';
	} elsif ($type eq 'md5' || $type eq 'md5patch') {
		return '.{32}';
	} else {
		return undef;
	}
}

# Запись элемента
sub writeElem {
	local $elem = defined($_[0]) ? $_[0] : die "Отсутствует имя элемента!\n";
	local $elemVar = defined($_[1]) ? $_[1] : '';

	# Если элемент массив
	if ($elem ~~ @elemArr || $elem =~ m/C/) {
		push @{${$book}{$NAME}{$elem}}, $elemVar;
	} else {
		${$book}{$NAME}{$elem} = $elemVar;
	}
}

# Создание элемента
sub createElement {
	local $elem = $_[0];
	local $mandatory = defined($_[1]) ? $_[1] : 0;
	local $template = template ($elem);

	print 'Введите ' . $elem . ' пакета ' . $NAME . ":\n";
	while (${$elem} = <STDIN>) {
		chomp(${$elem}); # отсекаем символ \n
		if (defined $template) {
			if (${$elem} =~ m/$template/) {
				writeElem ($elem, ${$elem});
				return 1;
			}
		} elsif ($mandatory == 0 || ${$elem} ne '') {
			writeElem ($elem, ${$elem});
			return 1;
		}
		print 'Введите ' . $elem . ' пакета ' . $NAME . ":\n";
	}
}

# Значение элемента
sub reply {
	local $elemName = defined($_[0])
						? $_[0]
						: die "Отсутствует название элемента!\n";
	local $message = 'Желаете добавить ' . $elemName . ' для ' . $NAME . '(Y/N):';

	# Проверка на совместимость главе
	if ($elemName =~ m/C/) {
		local $chapter = substr($elemName, -2);
		if (!defined($chapter =~ @{${$book}{$NAME}{'chapter'}})) {
			die 'Пакету ' . $NAME . ' не добавлена глава ' . $chapter . "!\n";
		}
	}

	print $message . "\n";
	while ($read = <STDIN>) {
		chomp($read); # отсекаем символ \n
		if ($read eq 'Y' || $read eq 'y') {
			return 1;
		} elsif ($read eq 'N' || $read eq 'n') {
			return 0;
		} else {
			print $message . "\n";
		}
	}
}

# Удаление пакета
if (defined $opts{'d'}) {
	local $elem = $opts{'d'};

	if ($elem eq 'all') {
		print "Удоляем весь пакет\n";
		delete(${$book}{$NAME});
	} elsif (defined(${$book}{$NAME}{$elem})) {
		print 'Удоляем элемент ' . $elem . "\n";
		delete(${$book}{$NAME}{$elem});
	}
}

# Добавление нового пакета
if (defined $opts{'a'}) {
	if ($opts{'a'} ne 'all') {
		if (${$book}{$NAME}{'link'}) {
			if ($opts{'a'} ~~ @signLink || $opts{'a'} =~ m/C/) {
				defined(${$book}{$NAME}{$opts{'a'}})
					and die 'Элемент ' . $opts{'a'} . ' ссылки ' . $NAME . " существует!\n";
			} else {
				die 'Элемент ' . $opts{'a'} . ' должен принадлежать пакету ' . ${$book}{$NAME}{'link'} . "!\n";
			}
		} else {
			defined(${$book}{$NAME}{$opts{'a'}})
				and die 'Элемент ' . $opts{'a'} . ' пакета ' . $NAME . " существует!\n";
		}

		if ($opts{'a'} ~~ @elemArr || $opts{'a'} =~ m/C/) {
			while (reply($opts{'a'})) {
				if ($opts{'a'} =~ m/patch/) {
					createElement ('urlpatch', 1);
					createElement ('md5patch', 1);
				} else {
					createElement ($opts{'a'}, 1);
				}
			}
		} else {
			createElement ($opts{'a'}, 1);
		}
	} else {
		defined(${$book}{$NAME})
			and die 'Пакет ' . $NAME . " существует!\n";

		# Новый пакет включён
		${$book}{$NAME}{"status"} = 1;
		# Новый пакет не ссылка
		${$book}{$NAME}{"type"} = 'pkg';
		# Глава пакета по умолчанию
		${$book}{$NAME}{"chapter"} = $CHAPTER;

		createElement ('version', 1); # Version
		createElement ('url', 1); # URL
		createElement ('md5', 1); # MD5

		while (reply('patch')) {
			createElement ('urlpatch', 1); # URL патча
			createElement ('md5patch', 1); # MD5 патча
		}

		while (reply('chapter')) {
			createElement ('chapter', 1); # Глава
		}

		foreach $chapter (values ${$book}{$NAME}{'chapter'}) {
			while (reply($chapter)) {
				createElement ('C' . $chapter, 1); # Порядок
			}
		}
	}
}

# Изменение пакета
if (defined $opts{'m'}) {
#	my $elem = $opts{'m'};

	# Если пакт не сушествует
	defined(${$book}{$NAME})
		or die 'Пакет ' . $NAME . " не сушествует!\n";

	# Удоляем элемент
	if (${$book}{$NAME}{'link'}) {
		if (!defined($opts{'m'} ~~ @signLink)) {
			if (!defined($opts{'m'} =~ m/C/)) {
				die 'Элемент ' . $opts{'m'} . ' должен принадлежать пакету ' . ${$book}{$NAME}{'link'} . "!\n";
			}
		}
	}
	defined(${$book}{$NAME}{$opts{'m'}})
		and delete(${$book}{$NAME}{$opts{'m'}});

	if ($opts{'m'} ~~ @elemArr || $opts{'m'} =~ m/C/) {
		while (reply($opts{'m'})) {
			createElement ($opts{'m'}, 1);
		}
	} else {
		createElement ($opts{'m'}, 1);
	}
}

# Добовляем ссылку на другой пакет
if (defined $opts{'l'}) {
	# Если пакт не сушествует
	defined(${$book}{$NAME})
		and die 'Ссылка ' . $NAME . " уже сушествует!\n";

	# Новый пакет включён
	${$book}{$NAME}{"status"} = 1;
	# Новый пакет ссылка
	${$book}{$NAME}{"type"} = 'link';
	# Имя главного пакета
	${$book}{$NAME}{"link"} = $opts{'l'};
	# Глава по умолчанию
	${$book}{$NAME}{"chapter"} = $CHAPTER;

	while (reply('главу')) {
		createElement ('chapter', 1, 'arr'); # Глава
	}

	foreach $chapter (values ${$book}{$NAME}{'chapter'}) {
		while (reply('порядок главы ' . $chapter)) {
			createElement ('C' . $chapter, 1, 'arr'); # Порядок
		}
	}
}

# Записываем изменения в файл
open (my $fh, '>', $file)
	or die "Не удалось открыть '$file' !";

# Записываем модуль
print $fh 'package ' . $BOOK . ";\n\n";

# Записываем глобальную переменную
print $fh 'our %pkg = (';

# Флаг новой линии
my @newLine;
$newLine[0] = 0;
$newLine[1] = 0;
$newLine[2] = 0;

sub endLine {
	if ($_[0] > 0) {
		print $fh ",\n";
	} else {
		print $fh "\n";
	}
}

# Перебераем пакеты массива
foreach $name (keys %{$book}) {
	endLine($newLine[0]);
	$newLine[0] = 1;

	# Записываем имя пакета
	print $fh "\n\"" . $name . '" => {';
	$newLine[1] = 0;
	# Перебераем элементы пакета
	foreach $key (keys ${$book}{$name}) {
		endLine($newLine[1]);
		# Если элемент массив
		if (ref(${$book}{$name}{$key}) eq 'ARRAY') {
			$newLine[2] = 0;
			# Записываем загаловок элемента массива
			print $fh "\t\"" . $key . '" => [';
			# Перебираем значения массива
			foreach $value (values ${$book}{$name}{$key}) {
				endLine($newLine[2]);
				# записываем значения массива
				print $fh "\t\t\"" . $value . '"';
				$newLine[2] = 1;
			}
			print $fh "\n\t\]";
		# Если элемент переменная
		} elsif (ref(${$book}{$name}{$key}) eq '') {
			# Записываем элемент
			print $fh "\t\"" . $key . '" => "' . ${$book}{$name}{$key} . '"';
		}
		$newLine[1] = 1;
	}
	# Заверщение записи пакета
	print $fh "\n\n}";
}
# Завершение записи модуля
print $fh "\n\n);\n\n1;";
close $fh;
