@echo off

echo Hola Mundo > mytext.txt
type mytext.txt

mkdir backup
copy mytext.txt backup\

echo Contenido de backup:
dir backup

del backup\mytext.txt
rmdir backup
