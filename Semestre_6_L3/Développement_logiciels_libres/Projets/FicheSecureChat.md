# Projet: Secure_chat - Application de chat sécurisée

URL: https://github.com/IvanTopGaming/Secure_chat
## Description

    Application web de chat sécurisée permettant d'échanger des messages de manière chiffrée entre utilisateurs
    Les utilisateurs peuvent créer un compte, se connecter et communiquer par chat avec d'autres utilisateurs connectés
    Les messages sont chiffrés de bout en bout pour garantir la confidentialité des échanges

## Technologies utilisées

    Langages: Python, JavaScript, HTML, CSS
    Framework: Flask, Node.js
    Bibliothèques: Flask-Login, Flask-SocketIO, OpenSSL
    Stockage de données: base de données SQLite
    Chiffrement: RSA, AES

## Fonctionnalités

    Inscription et authentification des utilisateurs
    Interface de chat en temps réel avec SocketIO
    Chiffrement asymétrique RSA pour l'échange de clés de session
    Chiffrement symétrique AES 256 pour les messages
    Gestion des contacts et liste d'amis
    Notifications de nouveaux messages
    Historique des conversations

## Organisation du code

    Dossier backend: application Flask avec routes API et modèles
    Dossier frontend: interface utilisateur avec React
    Dossier common: classes partagées comme User
    Fichiers routes.py, models.py, app.py
    Organisation en blueprint pour les différentes sections

## Développement

    Versionning: Git
    Tests: non documenté
    Déploiement: Heroku
    Documentation: peu de comments dans le code

## Contributeurs

    IvanTopGaming
    Raphaelmos


Mise en place de rsa / aes / connection avec flask et authentification et interface
