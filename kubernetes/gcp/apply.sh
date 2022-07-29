#! /bin/bash

cd web || exit
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml

cd ../docs || exit
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml

cd ../api || exit
kubectl apply -f service.yaml
kubectl apply -f deployment.yaml

cd ../shared || exit
kubectl apply -f cert.yaml
kubectl apply -f ingress.yaml