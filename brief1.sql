CREATE DATABASE IF NOT EXISTS S6_MVC_BTP;
create table IF NOT EXISTS Client(id int PRIMARY KEY AUTO_INCREMENT, Nom varchar(255), aneeNais int, ville varchar(255));
CREATE TABLE IF NOT EXISTS Fournisseur(id int PRIMARY KEY AUTO_INCREMENT, nom varchar(255), age int, ville varchar(255));
CREATE TABLE IF NOT EXISTS Produit(label varchar(255), idF int, prix float, PRIMARY KEY (`label`,`idF`)); 
CREATE TABLE IF NOT EXISTS Commande(num int , idC int, labelP varchar(255), qte float, PRIMARY KEY(`num`,`idC`,`labelP`));
INSERT INTO fournisseur VALUES('1','Abounayan','52','92190 Meudon');
INSERT INTO fournisseur VALUES('2','Cima','37','44150 Nantes');
INSERT INTO fournisseur VALUES('3','Preblocs','48','92230 Gennevilliers');
INSERT INTO fournisseur VALUES('4','Samaco','61','75018 Paris');
INSERT INTO fournisseur VALUES('5','Damasco','29','49100 Angers');
INSERT INTO client VALUES('1','Jean','1965','75006 Paris');
INSERT INTO client VALUES('2','Paul','1958','75003 Paris');
INSERT INTO client VALUES('3','Vincent','1954','94200 Evy');
INSERT INTO client VALUES('4','Pierre','1950','92400 Courbe');
INSERT INTO client VALUES('5','Daniel','1963','44000 Nantes');
INSERT INTO produit VALUES('sable','1','300');
INSERT INTO produit VALUES('briques','1','1500');
INSERT INTO produit VALUES('parpaing','1','1150');
INSERT INTO produit VALUES('sable','2','350');
INSERT INTO produit VALUES('tuiles','3','1200');
INSERT INTO produit VALUES('parpaing','3','1300');
INSERT INTO produit VALUES('briques','4','1500');
INSERT INTO produit VALUES('ciment','4','1300');
INSERT INTO produit VALUES('parpaing','4','1450');
INSERT INTO produit VALUES('briques','5','1450');
INSERT INTO produit VALUES('tuiles','5','1100');
INSERT INTO commande VALUES('1','1','briques','5');
INSERT INTO commande VALUES('1','1','ciment','10');
INSERT INTO commande VALUES('2','2','briques','12');
INSERT INTO commande VALUES('2','2','sable','9');
INSERT INTO commande VALUES('2','2','parpaing','15');
INSERT INTO commande VALUES('3','3','sable','17');
INSERT INTO commande VALUES('4','4','briques','8');
INSERT INTO commande VALUES('4','4','tuiles','17');
INSERT INTO commande VALUES('5','5','parpaing','10');
INSERT INTO commande VALUES('5','5','ciment','14');
INSERT INTO commande VALUES('6','5','briques','21');
INSERT INTO commande VALUES('7','2','ciment','12');
INSERT INTO commande VALUES('8','4','parpaing','8');
INSERT INTO commande VALUES('9','1','tuiles','15');

SELECT * FROM `client` --Q1
SELECT nom,aneeNais,ville FROM `client` --Q2
SELECT nom FROM `client` WHERE `aneeNais`< 1971 --Q3
SELECT DISTINCT label FROM `produit` --Q3
SELECT DISTINCT label FROM `produit` ORDER BY label DESC --Q4
SELECT * FROM `commande` WHERE qte BETWEEN 8 AND 18 --Q4
SELECT * FROM `commande` WHERE qte > 8 AND qte < 18 --Q5
SELECT * FROM `client` WHERE Nom LIKE 'p%' --Q6
SELECT * FROM `fournisseur` WHERE ville LIKE '%Paris%' --Q7
SELECT * FROM `produit` WHERE label = 'briques' OR label = 'parpaing' --Q8
SELECT * FROM `produit` WHERE label IN ('briques', 'parpaing') --Q9
SELECT nom, labelP, qte FROM `client` ct INNER JOIN commande as cm WHERE ct.id = cm.idC --Q10
SELECT nom, labelP FROM `client`,`commande` --Q11
SELECT COUNT(nom) FROM `client`,`commande` --Q11 
SELECT Nom from client as ct INNER JOIN commande as cm ON ct.id = cm.idC where cm.labelP='briques' ORDER BY Nom ASC --Q12
SELECT nom FROM fournisseur as fn INNER JOIN produit as pt ON fn.id = pt.idF WHERE pt.label = 'briques' OR pt.label='parpaing' --Q13
SELECT nom FROM(SELECT * FROM fournisseur as fn INNER JOIN produit as pt ON fn.id = pt.idF WHERE pt.label='briques' OR pt.label = 'parpaing') as  name --Q13-b
SELECT label FROM produit AS pt INNER JOIN fournisseur as fn ON pt.idF = fn.id WHERE fn.ville LIKE '%Paris%'--Q13-premiere methode jointure
SELECT label FROM (SELECT * FROM produit AS pt INNER JOIN fournisseur as fn ON pt.idF = fn.id WHERE fn.ville LIKE '%Paris%') as lab --13-2eme methode imbriquée
SELECT DISTINCT(label) FROM `fournisseur` AS fn,`produit` AS pt WHERE fn.ville LIKE '%Paris%' --Q13-methode cartésien 
SELECT nom, ville FROM client as ct INNER JOIN commande as cmd ON ct.id = cmd.idC where cmd.qte BETWEEN 10 AND 15 --Q14
SELECT DISTINCT nom, label, prix FROM fournisseur as fn INNER JOIN produit as pr ON fn.id = pr.idF where pr.label IN(SELECT labelP FROM commande AS cmd INNER JOIN client ct ON cmd.idC = ct.id WHERE ct.nom = 'Jean') ORDER BY label --Q15
SELECT * FROM fournisseur AS fn INNER JOIN produit as pr ON fn.id = pr.idF WHERE fn.id IN(SELECT idF from produit as pr ORDER BY label ASC) GROUP BY nom --Q16
SELECT label, AVG(prix) FROM produit GROUP BY label --Q17
SELECT label, AVG(prix) FROM produit GROUP BY label HAVING AVG(prix) > 1200--Q18
SELECT label, AVG(prix) FROM produit GROUP BY label HAVING AVG(prix) < (SELECT AVG(prix) FROM produit)--Q19
SELECT nom, label, AVG(prix) from fournisseur as fn INNER JOIN produit as pr ON fn.id = pr.idF GROUP BY nom --Q20







