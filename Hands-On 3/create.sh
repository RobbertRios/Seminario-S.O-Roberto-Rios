echo "Hello World" > mytext

echo "Contenido de mytext:"
cat mytext

mkdir -p backup
mv mytext backup/

echo "Contenido de backup:"
ls backup

rm backup/mytext
rmdir backup
