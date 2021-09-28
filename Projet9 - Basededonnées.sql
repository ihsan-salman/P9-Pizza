CREATE TABLE IF NOT EXISTS pizzeria
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	adresse VARCHAR(100) NOT NULL,
	num_tel VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS ingredient
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nom VARCHAR(20) NOT NULL,
	type VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS stock
(	
	pizzeria_id INT NOT NULL,
	ingredient_id INT NOT NULL,
	unite_mesure VARCHAR(15),
	quantite DECIMAL(5,2),
	CONSTRAINT FK_Pizzeria_id FOREIGN KEY (pizzeria_id) REFERENCES pizzeria(id),
	CONSTRAINT FK_ingredient_id FOREIGN KEY (ingredient_id) REFERENCES ingredient(id)
);

CREATE TABLE IF NOT EXISTS utilisateur
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nom VARCHAR(20) NOT NULL,
	prenom VARCHAR(20) NOT NULL,
	adresse_mail VARCHAR(50) NOT NULL,
	identifiant VARCHAR(20) NOT NULL,
	mot_de_passe VARCHAR(20) NOT NULL,
	num_tel VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS gerant
(
	utilisateur_id INT NOT NULL,
	pizzeria_id INT NOT NULL,
	CONSTRAINT FK_utilisateur_id FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id),
	CONSTRAINT FK_Pizzeria_id1 FOREIGN KEY (pizzeria_id) REFERENCES pizzeria(id)
);

CREATE TABLE IF NOT EXISTS employe
(
	utilisateur_id INT NOT NULL,
	pizzeria_id INT NOT NULL,
	CONSTRAINT FK_utilisateur_id1 FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id),
	CONSTRAINT FK_Pizzeria_id2 FOREIGN KEY (pizzeria_id) REFERENCES pizzeria(id)
);

CREATE TABLE IF NOT EXISTS client
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	utilisateur_id INT NOT NULL,
	adresse VARCHAR(50),
	CONSTRAINT FK_utilisateur_id2 FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id)
);

CREATE INDEX index_adresse ON client(adresse);

CREATE TABLE IF NOT EXISTS categorie
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nom VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS produit
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nom VARCHAR(20) NOT NULL,
	description VARCHAR(500),
	prix_unittaire DECIMAL(4,2),
	categorie_id INT NOT NULL,
	CONSTRAINT FK_categorie_id FOREIGN KEY (categorie_id) REFERENCES categorie(id)
);

CREATE TABLE IF NOT EXISTS pizza
(
	produit_id INT NOT NULL,
	taille VARCHAR(10) NOT NULL,
	ingredient VARCHAR(200),
	description_recette VARCHAR(2000) NOT NULL,
	CONSTRAINT FK_produit_id FOREIGN KEY (produit_id) REFERENCES produit(id)
);

CREATE TABLE IF NOT EXISTS commande
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	statut_paiement VARCHAR(10) NOT NULL,
	etat_commande VARCHAR(20),
	client_id INT NOT NULL,
	pizzeria_id INT NOT NULL,
	CONSTRAINT FK_client_id FOREIGN KEY (client_id) REFERENCES client(id),
	CONSTRAINT FK_Pizzeria_id3 FOREIGN KEY (pizzeria_id) REFERENCES pizzeria(id)
);

CREATE TABLE IF NOT EXISTS livreur
(
	utilisateur_id INT NOT NULL,
	CONSTRAINT FK_utilisateur_id3 FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id)
);

CREATE TABLE IF NOT EXISTS livraison
(
	commande_id INT NOT NULL,
	etat_livraison VARCHAR(20) NOT NULL,
	statut_paiement VARCHAR(10) NOT NULL,
	CONSTRAINT FK_commande_id1 FOREIGN KEY (commande_id) REFERENCES commande(id)
);

CREATE TABLE IF NOT EXISTS produit_commande
(
	commande_id INT NOT NULL,
	produit_id INT NOT NULL,
	quantite INT NOT NULL,
	prix_total DECIMAL(4,2) NOT NULL,
	CONSTRAINT FK_commande_id FOREIGN KEY (commande_id) REFERENCES commande(id),
	CONSTRAINT FK_produit_id1 FOREIGN KEY (produit_id) REFERENCES produit(id)
);

INSERT INTO pizzeria (adresse, num_tel) 
VALUES ('1 rue OP', '00 00 00 00 01'),
('2 rue OP', '00 00 00 00 02'),
('3 rue OP', '00 00 00 00 03');

INSERT INTO ingredient (nom, type)
VALUES ('eau', 'liquide'), ('huile', 'liquide'), ('farine', 'poudre'), ('tomate', 'légume'), 
('sauce tomate', 'sauce'), ('mozarella', 'fromage'), ('huile d olive', 'liquide'), ('champignon', 'plante'),
('peperoni', 'viande');

INSERT INTO stock (pizzeria_id, ingredient_id, unite_mesure, quantite)
VALUES (1, 1, 'litre', '200'), (1, 2, 'litre', '50'), (1, 3, 'kilogramme', '50'),
(1, 4, 'kilogramme', '20'), (1, 5, 'litre', '20'), (1, 6, 'kilogramme', '10'),
(1, 7, 'litre', '30'), (1, 8, 'kilogramme', '10'), (1, 9, 'kilogramme', '5');

INSERT INTO utilisateur (nom, prenom, adresse_mail, identifiant, mot_de_passe, num_tel)
VALUES ('salman', 'ihsan', 'ihsan.salman@gmail.com', 'ihsan', 'salman', '00 00 00 00 04'),
('salman2', 'ihsan2', 'ihsan.salman2@gmail.com', 'ihsan2', 'salman2', '00 00 00 00 05'),
('salman3', 'ihsan3', 'ihsan.salman3@gmail.com', 'ihsan3', 'salman3', '00 00 00 00 06'),
('salman4', 'ihsan4', 'ihsan.salman4@gmail.com', 'ihsan4', 'salman4', '00 00 00 00 07'),
('salman5', 'ihsan5', 'ihsan.salman5@gmail.com', 'ihsan5', 'salman5', '00 00 00 00 08'),
('salman6', 'ihsan6', 'ihsan.salman6@gmail.com', 'ihsan6', 'salman6', '00 00 00 00 09'),
('salman7', 'ihsan7', 'ihsan.salman7@gmail.com', 'ihsan7', 'salman7', '00 00 00 00 10'),
('salman8', 'ihsan8', 'ihsan.salman8@gmail.com', 'ihsan8', 'salman8', '00 00 00 00 11'),
('salman9', 'ihsan9', 'ihsan.salman9@gmail.com', 'ihsan9', 'salman9', '00 00 00 00 12');

INSERT INTO gerant (utilisateur_id, pizzeria_id) VALUES (1, 1), (1, 2), (1, 3);

INSERT INTO employe (utilisateur_id, pizzeria_id) VALUES (2, 1), (3, 1), (4, 1);

INSERT INTO client (utilisateur_id, adresse) VALUES (5, '4 rue OP'), (6, '5 rue OP'), (7, '6 rue OP'), (8, '7 rue OP');

INSERT INTO livreur (utilisateur_id) VALUES (9);

INSERT INTO categorie (nom) VALUES ('pizza'), ('boisson'), ('dessert'), ('salade');

INSERT INTO produit (nom, description, prix_unittaire, categorie_id) VALUES
('margherita', '', 9.50, 1), ('pizza au saumon', '', 9.50, 1),
('coca', '', 2.50, 2), ('pepsi', '', 2.50, 2),
('glace', '', 3, 3), ('cookie', '', 2, 3),
('cesar', '', 3, 4), ('tomate mozzarela', '', 3, 4);

INSERT INTO pizza (produit_id, taille, ingredient, description_recette) VALUES
(1, 'moyenne', 'ce qu il faut', 'comment faire'), (2, 'moyenne', 'ce qu il faut', 'comment faire');

INSERT INTO commande (statut_paiement, etat_commande, client_id, pizzeria_id) VALUES
('yes', 'en preparation', 1, 1), ('yes', 'en livraison', 2, 1), ('yes', 'livraison fini', 3, 1), ('yes', 'en preparation', 4, 1);

INSERT INTO produit_commande (commande_id, produit_id, quantite, prix_total) VALUES
(1, 1, 2, 19), (1, 3, 2, 5), (2, 2, 2, 19), (2, 4, 2, 5);

INSERT INTO livraison (commande_id, etat_livraison, statut_paiement) VALUES
(2, 'en route', 'no');

## Requêtes sql

# nom des utilisateurs qui ont une commande en livraison
SELECT utilisateur.nom FROM utilisateur,client, commande 
WHERE commande.etat_commande='en livraison' 
AND utilisateur.id=client.utilisateur_id AND client.id=commande.client_id;

# Produit commandé en fonction du numéro de la commande
SELECT produit.nom FROM produit, commande, produit_commande 
WHERE produit_commande.commande_id=commande.id 
AND produit_commande.produit_id=produit.id AND produit_commande.commande_id=1;

# état de la livraison d une commande
SELECT livraison.etat_livraison FROM livraison, commande 
WHERE commande.etat_commande='en livraison';

# état de la commande d un client en particulier
SELECT commande.etat_commande FROM commande, client 
WHERE client.id=2 AND commande.client_id = client.id;

# le mail du gérant de la pizzeria 1
SELECT utilisateur.adresse_mail FROM utilisateur, gerant, pizzeria 
WHERE utilisateur.id=gerant.utilisateur_id AND pizzeria.id=gerant.pizzeria_id
AND gerant.pizzeria_id=1;

# le prix d un produit
SELECT produit.prix_unittaire FROM produit 
WHERE produit.nom='coca';

# l adresse d un des emplacements de la pizzeria
SELECT pizzeria.adresse FROM pizzeria WHERE pizzeria.id='3';

# la quantité restante d un ingrédient
SELECT stock.quantite FROM stock, pizzeria, ingredient
WHERE pizzeria.id='1' AND ingredient.id='1'AND pizzeria.id=stock.pizzeria_id 
AND ingredient.id=stock.ingredient_id;
