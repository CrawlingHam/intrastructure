# ECS Infrastructure

This directory contains the ECS cluster infrastructure configuration.

## Architecture

The ECS cluster is managed through Terraform and provides the foundational infrastructure for containerized applications. However, **ECS services and task definitions are NOT managed here**.

## ECS Services and Task Definitions

ECS services and task definitions are defined and managed in their respective microservice repositories through CI/CD pipelines. This separation provides:

-   **Independent deployments**: Each microservice can deploy without affecting infrastructure
-   **Team ownership**: Application teams own their deployment configurations
-   **Flexibility**: Services can be updated, scaled, and managed independently
-   **CI/CD integration**: GitHub workflows handle application-specific deployments

## What's Managed Here

-   ECS Cluster configuration
-   Cluster capacity providers (FARGATE, FARGATE_SPOT)
-   Cluster-level settings and monitoring

## What's NOT Managed Here

-   ECS Services
-   Task Definitions
-   Container image builds
-   Service scaling and updates

## For Application Teams

When deploying applications to this cluster, use the cluster name and ARN outputs provided by this infrastructure in your CI/CD pipelines.
