# Shieldrule in Kubernetes

## Overview
This directory deploys shieldrule-web, shieldrule-api and shieldrule-docs as Kubernetes pods inside a cluster.

The recommended way to use this is with a GKE cluster which can be deployed through `@/infrastructure/terraform/gcp/app`. 
That directory provisions a GKE cluster and surrounding resources in Google Cloud Platform.

## Deployment
1. Create a GKE cluster and other resources through `@/infrastructure/terraform/gcp/app`
2. Configure kubectl for access to the GKE cluster   
3. Push images to Google Artifact Registry, to the docker registries made by `@/infrastructure/terraform/gcp/app`
4. Provision static external IP addresses through Google VPC network and assign the IPs to each service's ingress file
5. Run `@/infrastructure/kubernetes/apply.yaml`, which will deploy all services


## Monitoring / troubleshooting

`kubectl get services` - list all services in a kubernetes namespace

`kubectl get deployments` - list all deployments for services in a namespace

`kubectl logs deploy/{deployment_name}` - get logs for a deployment

`kubectl get events --sort-by='.lastTimestamp'` - get all events in chronological order, separated by event type