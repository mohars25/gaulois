
1.INSERT INTO personnage (nom_personnage, adresse_personnage, id_specialite, id_lieu)
VALUES (
	'Champdeblix', 'Résidant à la ferme Hantassion',
	(SELECT id_specialite FROM specialite WHERE specialite.nom_specialite = 'Agriculteur'),
	(SELECT id_lieu FROM lieu WHERE nom_lieu = 'Rotomagus')
)




2.
INSERT INTO autoriser_boire (id_personnage, id_potion)
VALUES (
	(SELECT id_personnage FROM personnage WHERE nom_personnage = 'Bonemine'),
	(SELECT id_potion FROM potion WHERE nom_potion = 'Magique')
)


3.
DELETE FROM casque 
WHERE id_type_casque = (
	SELECT id_type_casque 
	FROM type_casque
	WHERE nom_type_casque = "Grec"
	)
AND id_casque NOT IN (
	SELECT id_casque 
	FROM prendre_casque
	)

4.
UPDATE personnage p
SET p.adresse_personnage = 'Prison de Condate'
WHERE p.nom_personnage = "Zérozérosix"


DELETE composer
FROM composer
LEFT JOIN potion 
ON potion.id_potion = composer.id_potion
LEFT JOIN ingredient 
ON ingredient.id_ingredient = composer.id_ingredient
WHERE potion.nom_potion = "Soupe" 
AND ingredient.nom_ingredient = "Persil"

5.
UPDATE prendre_casque pc 
SET qte = 42, id_casque = (
    SELECT id_casque 
    FROM casque 
    WHERE nom_casque = 'Weisenau' 
    )
WHERE id_personnage = (
    SELECT id_personnage 
    FROM personnage 
    WHERE nom_personnage = 'Obélix'
    ) 
AND id_bataille = (
    SELECT id_bataille 
    FROM bataille 
    WHERE nom_bataille = 'Attaque de la banque postale' 
    )


