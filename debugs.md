
# debug3.py

Avec Python 2, l'appel `input` évalue la chaîne en entrée, ce qui permetterait
de réassigner le dictionnaire `admin_data` et avoir accès.

Aussi, le hash du mot de passe est comparé avec l'opérateur `!=`, ce qui le
rend vulnérable à une attaque basée sur le temps.

Si on a deviné la moitié du hash, le programme prend la moitié du temps
à exécuter, ce qui facilite la découverte d'une collision.

# Debug4.java

Le litéral `01234` correspond à sa valeur octale à cause du zéro en dernière
position.

# Debug5.java

La représentation IEE754 du nombre `2.20` n'est pas exacte (2.200000047683716).

