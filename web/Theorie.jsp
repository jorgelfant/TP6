<%--
  Created by IntelliJ IDEA.
  User: JORGE
  Date: 2/16/2020
  Time: 10:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%--
************************************************************************************************************************
                                            TP Fil rouge - Étape 4
************************************************************************************************************************

Les sessions constituant déjà un gros morceau à elles seules, dans cette étape du fil rouge vous n'allez pas manipuler
de cookies. Et croyez-moi, même sans ça vous avez du pain sur la planche !

************************************************************************************************************************
                                                 Objectifs
************************************************************************************************************************

***************
Fonctionnalités
***************

Vous allez devoir effectuer une modification importante, qui va impacter presque tout votre code existant : je vous
demande dans cette étape d'enregistrer en session les clients et commandes créés par un utilisateur. Cela pourrait très
bien être un jeu d'enfants, si je ne vous demandais rien d'autre derrière... Mais ne rêvez pas, vous n'êtes pas ici pour
vous tourner les pouces ! :p

*************************
Enregistrement en session
*************************

Pour commencer, comme je viens de vous l'annoncer, vous allez devoir enregistrer en session les clients et commandes
créés par un utilisateur. Ainsi, les informations saisies par l'utilisateur ne seront plus perdues après validation
d'un formulaire de création !

***************************************************
Liste récapitulative des clients et commandes créés
***************************************************

Deuxièmement, vous allez devoir créer deux nouvelles pages :

      * listerClients.jsp, qui listera les clients créés par l'utilisateur ;

      * listerCommandes.jsp, qui listera les commandes créées par l'utilisateur.

Vous les placerez bien entendu sous /WEB-INF tout comme leurs consœurs, Vous en profiterez pour mettre à jour la page
menu.jsp en y ajoutant deux liens vers les nouvelles servlets gérant ces deux pages fraîchement créées.

***************************************************
Un formulaire de création de commande intelligent
***************************************************

Troisièmement, et cette fois il va falloir réfléchir davantage, je vous demande de modifier le formulaire de création
de commandes. Maintenant que votre application est capable d'enregistrer les clients créés par l'utilisateur, vous allez
lui donner un choix lorsqu'il crée une commande :

   * si la commande qu'il veut créer concerne un nouveau client, alors affichez-lui les champs permettant la saisie des
     informations du nouveau client, comme vous le faisiez déjà auparavant ;

   * si la commande qu'il veut créer concerne un client déjà existant, alors affichez-lui une liste déroulante des clients
     existants, lui permettant de choisir son client et lui évitant ainsi de saisir à nouveau ces informations.

***************************************************
Système de suppression des clients et commandes
***************************************************

Quatrièmement, vous allez devoir mettre en place un système permettant la suppression d'un client ou d'une commande
enregistrée dans la session. Vous allez ensuite devoir compléter vos pages listerClients.jsp et listerCommandes.jsp pour
qu'elles affichent à côté de chaque client et commande un lien vers ce système, permettant la suppression de l'entité
correspondante.

***************************************************
Gestion de l'encodage UTF-8 des données
***************************************************

Cinquièmement, vous allez appliquer le filtre d'encodage de Tomcat à votre projet, afin de rendre votre application
capable de gérer n'importe quelle donnée UTF-8.

Enfin, vous devrez vous préparer une tasse un thermos de café ou de thé bien fort, parce qu'avec tout ce travail, vous
n'êtes pas couchés !

***************************************************
Exemples de rendus
***************************************************

Voici aux figures suivantes quelques exemples de rendu.
Liste des clients créés au cours de la session, ici avec quatre clients.







Liste des commandes lorsqu'aucune commande n'a été créée au cours de la session :







Formulaire de création d'une commande lorsque la case "Nouveau client : Oui" est cochée :








Formulaire de création d'une commande lorsque la case "Nouveau client : Non" est cochée :







Liste des commandes lorsque deux commandes ont été créées au cours de la session :







************************************************************************************************************************
                                                   Conseils
************************************************************************************************************************


****************************
Enregistrement en session
****************************

Concernant l'aspect technique de cette problématique, vous avez toutes les informations dans le chapitre sur ce sujet :
il vous suffit de récupérer la session en cours depuis l'objet requête, et d'y mettre en place des attributs. Concernant
la mise en place dans ce cas précis par contre, il y a une question que vous allez devoir vous poser : quel type
d'attributs enregistrer en session ? Autrement dit, comment stocker les clients et commandes ? C'est une bonne question.
Essayez d'y réfléchir par vous-mêmes avant de lire le conseil qui suit...

Ici, ce qui vous intéresse, c'est d'enregistrer les clients et les commandes créés. Une liste de clients et une liste
de commandes pourraient donc a priori faire l'affaire, mais retrouver quelque chose dans une liste, ce n'est pas simple...
Pourtant, vous aimeriez bien pouvoir identifier facilement un client ou une commande dans ces listes. Pour cette raison,
une Map semble la solution adaptée. Oui, mais comment organiser cette Map ? Les objets Client et Commande seront bien
entendu les valeurs, mais qu'est-ce qui va bien pouvoir servir de clé ? Il y a tout un tas de solutions possibles, mais
je vous conseille pour le moment de mettre en place la moins contraignante : considérez que le nom permet d'identifier
de manière unique un client, et que la date permet d'identifier de manière unique une commande. Cela implique que votre
application ne permettra pas de créer deux commandes au même instant, ni de créer deux clients portant le même nom.
Ce n'est pas génial comme comportement, mais pour le moment votre application ne gère toujours pas les données, donc ça
ne vous pose absolument aucun problème ! Vous aurez tout le loisir de régler ce petit souci dans l'étape 6 du fil rouge ! :D

Bref, je vous conseille donc de placer en session une Map<String, Client> contenant les clients identifiés par leur nom,
et une Map<String, Commande> contenant les commandes identifiées par leur date.

****************************************************
Liste récapitulative des clients et commandes créés
****************************************************

Deux pages JSP accédant directement aux attributs stockés en session suffisent ici. Puisque vous allez les placer sous
/WEB-INF, elles ne seront pas accessibles directement par leur URL et vous devrez mettre en place des servlets en amont,
qui se chargeront de leur retransmettre les requêtes reçues. Vous pouvez par exemple les appeler ListeClients et
ListeCommandes, et vous n'oublierez pas de les déclarer dans votre fichier web.xml.

Dans chacune de ces JSP, le plus simple est de générer un tableau HTML qui affichera ligne par ligne les clients ou
commandes créés (voir les exemples de rendus). Pour cela, il vous suffit de parcourir les Map enregistrées en tant
qu'attributs de session à l'aide de la balise de boucle JSTL <c:forEach>. Relisez le passage du cours sur la JSTL si
vous avez oublié comment itérer sur une collection, et relisez la correction de l'exercice sur la JSTL Core si vous avez
oublié comment atteindre les clés et valeurs d'une Map depuis une EL ! Dans le corps de cette boucle, vous placerez les
balises HTML nécessaires à la création des lignes du tableau HTML, contenant les entrées de la Map des clients ou des
commandes.

En bonus, pour aérer la lecture du tableau final dans le navigateur, vous pouvez utiliser un compteur au sein de votre
boucle pour alterner la couleur de fond d'une ligne à l'autre. Cela se fait par exemple en testant simplement si
l'indice de parcours de la boucle est pair ou impair.

Second bonus, vous pouvez mettre en place un test vérifiant si les objets présents en sessions existent ou non, via par
exemple la balise <c:choose> : si non, alors vous pouvez par exemple afficher un message signalant qu'aucun client ou
aucune commande n'existe (voir les exemples de rendus).

****************************************************
Un formulaire de création de commande intelligent
****************************************************

En ce qui concerne cette modification, vous allez devoir réfléchir un peu à la solution à mettre en place :
comment donner un choix à l'utilisateur ? Si vous regardez les exemples de rendus que je vous ai donnés ci-dessus,
vous verrez que j'ai mis en place deux simples boutons de type <input type="radio" /> :

     * au clic sur "Oui", la première partie du formulaire classique s'affiche ;

     * au clic sur "Non", un nouveau champ <select> listant les clients existants remplace la première partie du formulaire !

Bien entendu, vous n'êtes pas forcés d'utiliser ce moyen ! Si vous souhaitez que votre apprentissage soit efficace,
alors vous devez réfléchir par vous-mêmes à cette petite problématique et lui trouver une solution adaptée sans mon aide.
Ce petit exercice de conception donnera du fil à retordre à vos neurones et vous fera prendre encore un peu plus d'aisance
avec le Java EE ! ;)

En outre, la solution que je propose ici est un peu évoluée, car elle implique un petit morceau de code Javascript pour
permettre la modification du formulaire au clic sur un bouton radio. Si vous ne la sentez pas, prenez le temps et pensez
à un autre système plus simple et peut-être moins évolué graphiquement qui permettrait à l'utilisateur de choisir entre
une liste des clients existants et un formulaire classique comme vous l'affichiez par défaut auparavant.
Ne vous découragez pas, testez et réussissez !

Note : une telle modification du formulaire va bien évidemment impliquer une modification de l'objet métier qui y est
associé, c'est-à-dire CreationCommandeForm. En effet, puisque vous proposez la réutilisation d'un client existant à
l'utilisateur dans le formulaire, vous devrez faire en sorte dans votre objet métier de ne valider les informations
clients que si un nouveau client a été créé, et simplement récupérer l'objet Client existant si l'utilisateur choisit
un ancien client dans la liste !

***********************************************
Système de suppression des clients et commandes
***********************************************

Pour terminer, il vous suffit ici de créer deux servlets, dédiées chacune à la suppression d'un client et d'une commande
de la Map présente en session. Vous contacterez ces servlets via de simples liens HTML depuis vos pages listerClients.jsp
ou listerCommandes.jsp ; il faudra donc y implémenter la méthode doGet(). Ces liens contiendront alors, soit un nom de
client, soit une date de commande en tant que paramètre d'URL, et les servlets se chargeront alors de retirer l'entrée
correspondante de la Map des clients ou des commandes, grâce à la méthode remove().

Dans les exemples de rendus ci-dessus, les croix rouges affichées en fin de chaque ligne des tableaux sont des liens
vers les servlets de suppression respectives, que vous pouvez par exemple nommer SuppressionClient et SuppressionCommande.

***************************************
Gestion de l'encodage UTF-8 des données
***************************************

Rien de particulier à vous conseiller ici, il suffit simplement de recopier la déclaration du filtre de Tomcat dans
le web.xml du projet, et le tour est joué ! ;)

************************************************************************************************************************
                                                  Correction
************************************************************************************************************************

Cette fois, la longueur du sujet n'est pas trompeuse : le travail que vous devez fournir est bien important ! :D
Posez-vous calmement les bonnes questions, faites l'analogie avec ce que vous avez appris dans les chapitres de cours
et n'oubliez pas les bases que vous avez découvertes auparavant (création d'une servlet, modification du fichier web.xml,
utilisation de la JSTL, etc.). Comme toujours, ce n'est pas la seule manière de faire, le principal est que votre
solution respecte les consignes que je vous ai données !

Pour que cette correction soit entièrement fonctionnelle, vous devrez inclure la bibliothèque jQuery dans le répertoire
/inc de votre projet, ainsi que le fichier image utilisé pour illustrer le bouton de suppression.

Voici les deux fichiers à télécharger :

jquery.js

supprimer.png

--%>

</body>
</html>
