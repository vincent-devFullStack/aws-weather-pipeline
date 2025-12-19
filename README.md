# aws-weather-pipeline

# AWS Weather Data Pipeline

## Présentation

Ce projet implémente un **pipeline de données météo sur AWS**, inspiré d’une architecture **Data Engineering industrielle**.  
Il couvre l’ingestion, le traitement, l’orchestration et l’exposition de données météorologiques à l’aide de services managés AWS.

L’objectif est de démontrer la mise en place d’un **pipeline cloud automatisé**, robuste et exploitable analytiquement.

---

## Objectifs du projet

- Concevoir une architecture Data Cloud reproductible
- Séparer clairement les couches **Landing / Refined**
- Automatiser les traitements via orchestration
- Rendre les données interrogeables avec Athena
- Préparer l’exploitation analytique (BI / dashboards)

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

Les données sont organisées selon une architecture **multi-couches** :

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

---

## Traitement des données (AWS Glue)

Un job AWS Glue basé sur **Apache Spark** est utilisé pour :

- Lire les données brutes depuis S3 Landing
- Nettoyer les enregistrements invalides
- Ajouter des métadonnées de traitement (date)
- Écrire les données en Parquet dans S3 Refined
- Gérer explicitement les partitions (`date`, `city`)

Le job est **paramétré dynamiquement** (bucket, clé S3) afin d’être déclenché automatiquement.

---

## Orchestration (AWS Step Functions)

Le pipeline est orchestré via une machine d’état AWS Step Functions :

1. Lancement du job AWS Glue
2. Exécution de requêtes Athena de validation
3. Gestion explicite des états de succès et d’échec

Cette orchestration garantit :

- la traçabilité des exécutions
- la gestion des erreurs
- la reproductibilité du pipeline

---

## Exposition & analyse (Amazon Athena)

Les données raffinées sont exposées via Amazon Athena :

- Tables externes sur données Parquet
- Partitionnement optimisé pour la performance
- Requêtes analytiques SQL (agrégations, séries temporelles)

Athena permet une analyse **serverless**, sans gestion d’infrastructure.

---

## Infrastructure as Code (Terraform)

Une partie de l’infrastructure est définie via **Terraform** :

- Buckets S3
- Rôles IAM
- Déploiement progressif des ressources

Objectif :

- Rendre le pipeline **reproductible**
- Limiter les configurations manuelles
- Faciliter les évolutions futures

---

## Points clés techniques

- Architecture orientée **Data Engineering Cloud**
- Séparation claire des responsabilités
- Partitionnement maîtrisé (performance / coûts)
- Orchestration robuste
- Approche production-ready

---

## Évolutions possibles

- Ajout d’une couche **Staging**
- Intégration de QuickSight pour la BI
- Gestion multi-sources météo
- Monitoring avancé (CloudWatch)
- Déploiement 100 % Terraform

---

## Auteur

Projet réalisé par **Vincent Silvestri**  
Orientation : **Data Engineering / Cloud AWS**
