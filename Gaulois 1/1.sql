1. SELECT nom_lieu
FROM Lieu
WHERE nom_lieu LIKE '%um'


	

2.SELECT L.nom_lieu, COUNT(*) AS nombre_personnages
FROM Personnage P
JOIN Lieu L ON P.id_lieu = L.id_lieu
GROUP BY L.nom_lieu
ORDER BY nombre_personnages DESC;
   
3.SELECT p.nom_personnage, s.nom_specialite, p.adresse_personnage ,l.nom_lieu
FROM specialite s
INNER JOIN personnage p 
ON p.id_specialite = s.id_specialite
INNER JOIN lieu l
ON p.id_lieu = l.id_lieu
ORDER BY l.nom_lieu DESC, p.nom_personnage DESC



4.SELECT s.nom_specialite, COUNT(p.id_personnage) AS nb_personnages
FROM specialite s
INNER JOIN personnage p
ON s.id_specialite = p.id_specialite
GROUP BY s.nom_specialite
ORDER by nb_personnages DESC


5.SELECT nom_bataille, DATE_FORMAT(date_bataille, '%d/%m/%Y') AS date_bataille, nom_lieu
FROM Bataille
JOIN Lieu ON Bataille.id_lieu = Lieu.id_lieu
ORDER BY date_bataille DESC;

6.SELECT p.nom_potion, SUM(i.cout_ingredient * c.qte) AS cout_total
FROM potion p 
INNER JOIN composer c
ON p.id_potion = c.id_potion
INNER JOIN ingredient i
ON c.id_ingredient = i.id_ingredient
GROUP BY p.nom_potion
ORDER BY cout_total



7.SELECT p.nom_potion, i.nom_ingredient ,i.cout_ingredient, c.qte, i.cout_ingredient * c.qte
FROM potion p 
INNER JOIN composer c
ON p.id_potion = c.id_potion
INNER JOIN ingredient i
ON c.id_ingredient = i.id_ingredient
WHERE nom_potion = "Santé"


8.SELECT p.nom_personnage, SUM(pc.qte) AS nb_casques
FROM personnage p, bataille b, prendre_casque pc
WHERE p.id_personnage = pc.id_personnage
AND pc.id_bataille = b.id_bataille
AND b.nom_bataille = 'Bataille du village gaulois'
GROUP BY p.id_personnage
HAVING nb_casques >= ALL( -- on retravaille avec les mêmes données pour les comparer
	SELECT SUM(pc.qte)
 	FROM prendre_casque pc, bataille b
 	WHERE b.id_bataille = pc.id_bataille -- jointure en join
 	AND b.nom_bataille = 'Bataille du village gaulois'
 	GROUP BY pc.id_personnage
)



9.
SELECT pot.nom_potion, p.nom_personnage, SUM(b.dose_boire) AS potion_bu 
FROM personnage p
INNER JOIN boire b
ON p.id_personnage = b.id_personnage
INNER JOIN potion pot
ON pot.id_potion = b.id_potion
GROUP BY p.id_personnage, pot.nom_potion
ORDER BY potion_bu ASC 


10.SELECT nom_bataille, SUM(qte) AS nbCasques
FROM prendre_casque
INNER JOIN bataille 
ON bataille.id_bataille = prendre_casque.id_bataille
GROUP BY prendre_casque.id_bataille
HAVING nbCasques >= ALL(
    SELECT SUM(qte)
    FROM prendre_casque pc, bataille b
    WHERE pc.id_bataille = b.id_bataille
    GROUP BY pc.id_bataille
    )


11.SELECT tc.nom_type_casque, COUNT(c.id_casque ) AS nb_casques, SUM(c.cout_casque) AS cout_total
FROM casque c 
LEFT JOIN type_casque tc
ON tc.id_type_casque = c.id_type_casque
GROUP BY tc.nom_type_casque
ORDER BY cout_total DESC 



12.SELECT p.nom_potion
FROM potion p
INNER JOIN composer c
ON p.id_potion = c.id_potion
INNER JOIN ingredient i
ON c.id_ingredient = i.id_ingredient
WHERE i.nom_ingredient = "poisson frais"





13.SELECT l.nom_lieu, COUNT(p.nom_personnage) AS nbPersonnage
FROM personnage p
INNER JOIN lieu l
ON p.id_lieu = l.id_lieu
WHERE l.nom_lieu != "Village gaulois"
GROUP BY l.id_lieu
HAVING nbPersonnage >= ALL(
	SELECT COUNT(p.nom_personnage)
	FROM personnage p, lieu l
	WHERE l.id_lieu = p.id_lieu
	AND NOT l.nom_lieu = 'Village gaulois'
	GROUP BY l.id_lieu
    )
	




14.
SELECT p.nom_personnage
FROM personnage p
WHERE p.id_personnage NOT IN(
    SELECT id_personnage 
    FROM boire
    )
GROUP BY p.nom_personnage





15.SELECT p.nom_personnage
FROM personnage p
WHERE p.id_personnage NOT IN(
    SELECT id_personnage 
    FROM autoriser_boire a, potion pot 
    WHERE pot.id_potion = a.id_potion 
    AND pot.nom_potion = "Magique"
    ) 

