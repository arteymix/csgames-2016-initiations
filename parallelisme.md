
1.

L'exécution concurrent, contrairement à la séquentielle, consiste à faire
progresser un ensemble de tâches dans un ordre arbitraire.

Le parallélisme est une forme de concurrence où les tâches peuvent progresser
simultanément dans le temps.

2.

La sémaphore binaire permet de contrôler l'exclusivité sur une ressource, c'est
à dire qu'un seul fil d'exécution pourra y accéder entre le verrou et la
relâche.

La sémaphore est plus générale et permet de limiter le nombre de fils
d'exécutions qui peuvent se trouver dans la section critique.

3.

4.

En gros, je ferais un tri fusion avec un pool de fils d'exécution.

 - les partitions sont exclusives, permettant du parallélisme sans lock
 - les fils d'exécutions diviseraient et réunirait les partitions

Mais bon, pas le temps.

