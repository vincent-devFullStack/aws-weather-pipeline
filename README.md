# AWS Weather Data Pipeline

## Présentation

Ce projet implémente un **pipeline de données météorologiques sur AWS**, inspiré d’une architecture **Data Engineering industrielle**.  
Il couvre l’ingestion, le traitement, l’orchestration et l’exposition de données météo à l’aide de services managés AWS.

L’objectif est de démontrer la mise en place d’un **pipeline cloud automatisé**, robuste, reproductible et exploitable analytiquement, dans une logique proche d’un environnement de production.

---

## Objectifs du projet

- Concevoir une architecture Data Cloud reproductible
- Séparer clairement les couches **Landing / Refined**
- Automatiser les traitements via orchestration
- Rendre les données interrogeables via une couche SQL (Athena / BI)
- Préparer l’exploitation analytique sans dépendre d’un outil spécifique

---

## Architecture globale

Pipeline logique :

API météo → S3 Landing → AWS Glue → S3 Refined → Amazon Athena → (BI)

Services AWS utilisés :

- Amazon S3
- AWS Glue (Spark ETL)
- AWS Step Functions
- Amazon Athena
- AWS IAM
- Terraform (Infrastructure as Code – en cours)

---

## Stockage des données (Amazon S3)

Les données sont organisées selon une architecture **multi-couches**, classique en Data Engineering.

### Landing

- Stockage brut des données météo
- Aucun traitement appliqué
- Source de vérité initiale

### Refined

- Données nettoyées et structurées
- Format **Parquet**
- Partitionnement optimisé :
  - `date`
  - `city`

Exemple de structure :

    weather/
    └── date=2025-11-20/
    ├── city=Paris/
    ├── city=Marseille/
    └── city=Nice/

Cette organisation permet :

- une réduction des coûts de scan Athena
- une amélioration des performances de requêtes
- une exploitation analytique efficace

---

## Traitement des données (AWS Glue)

Un job AWS Glue basé sur **Apache Spark** est utilisé pour :

- Lire les données brutes depuis S3 Landing
- Nettoyer les enregistrements invalides
- Ajouter des métadonnées de traitement (date)
- Écrire les données en Parquet dans S3 Refined
- Gérer explicitement les partitions (`date`, `city`)

Le job est **paramétré dynamiquement** (bucket, clé S3), ce qui permet :

- une exécution manuelle
- un déclenchement automatisé via orchestration

---

## Orchestration (AWS Step Functions)

Le pipeline est orchestré à l’aide d’une machine d’état AWS Step Functions :

1. Lancement du job AWS Glue
2. Exécution de requêtes Athena de validation
3. Gestion explicite des états de succès et d’échec

Cette orchestration garantit :

- la traçabilité des exécutions
- une gestion claire des erreurs
- la reproductibilité du pipeline

---

## Exposition & analyse (Amazon Athena)

Les données raffinées sont exposées via **Amazon Athena** :

- Tables externes sur données Parquet
- Partitionnement exploité par le moteur de requête
- Requêtes analytiques SQL (agrégations, séries temporelles)

Athena permet une analyse **serverless**, sans gestion d’infrastructure, tout en servant de couche d’accès standardisée aux données.

---

## Business Intelligence (BI)

Les données produites par le pipeline sont **prêtes à être consommées par un outil de BI**, via Amazon Athena comme couche d’accès SQL.

L’intégration avec **Amazon QuickSight** a été envisagée dans le cadre du projet.  
Cependant, l’activation du service QuickSight n’a pas pu être finalisée sur ce compte AWS en raison de limitations liées au service.

Ce point ne remet pas en cause :

- la structure des données,
- le partitionnement,
- ni la capacité d’exploitation analytique du pipeline.

Les tables et vues Athena constituent une **couche métier directement exploitable** par tout outil de visualisation compatible SQL.

---

## Infrastructure as Code (Terraform)

Une partie de l’infrastructure est définie via **Terraform** :

- Buckets S3
- Rôles IAM
- Ressources associées au pipeline

Objectifs :

- Rendre le pipeline **reproductible**
- Réduire les configurations manuelles
- Faciliter les évolutions et le déploiement multi-environnements

---

## Points clés techniques

- Architecture orientée **Data Engineering Cloud**
- Séparation claire des responsabilités par couche
- Partitionnement maîtrisé (performance / coûts)
- Orchestration robuste
- Approche **production-ready**

---

## Évolutions possibles

- Ajout d’une couche **Staging**
- Intégration d’un outil BI (Amazon QuickSight ou équivalent)
- Création de vues métier Athena
- Monitoring avancé (CloudWatch)
- Déploiement 100 % Terraform

---

## Auteur

Projet réalisé par **Vincent Silvestri**  
Orientation : **Data Engineering / Cloud AWS**
