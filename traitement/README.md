Il faut compiler l'extension de SQLite pour avoir accès aux fonctions
mathématiques.

```
make
```

De plus, il faut enlever la première ligne du fichier de données, sinon elle se
retrouve dans la base de données.

Le fichier `traitement.sql` est un script pour l'utilitaire `sqlite3`. Il
suffit de rouler:

```
LD_LIBRARY_PATH=. sqlite3 -init traitement.sql
```

