#!/bin/bash

# Очистка переменных
f_clear_per ()
{
for per in ${1}
do
	unset $(echo ${per} | cut -d= -f1)
done
}
