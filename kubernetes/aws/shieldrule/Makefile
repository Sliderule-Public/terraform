.ONESHELL:

set_namespace:
	kubectl config set-context --current --namespace=$(env)

use_aws_cluster:
	aws eks update-kubeconfig --region $(region) --name $(cluster)
	kubectl set env daemonset aws-node -n kube-system ENABLE_POD_ENI=true

install:
	helm install shieldrule --create-namespace -n $(env) -f values-$(env).yaml -f values-terraform-$(env).yaml .

upgrade:
	helm upgrade shieldrule . -n $(env) -f values-$(env).yaml -f values-terraform-$(env).yaml

uninstall:
	helm uninstall shieldrule -n $(env)

describe:
	kubectl get deployments -n $(env)
	kubectl get services -n $(env)