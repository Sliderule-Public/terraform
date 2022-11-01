.ONESHELL:

install_all: add_prerequisites
	@helm install shieldrule --create-namespace -n $(env) -f values-$(env).yaml -f values-terraform-$(env).yaml .

install:
	@helm install shieldrule --create-namespace -n $(env) -f values-$(env).yaml -f values-terraform-$(env).yaml .

upgrade:
	@helm upgrade shieldrule . -n $(env) -f values-$(env).yaml -f values-terraform-$(env).yaml

use_aws_cluster:
	@aws eks update-kubeconfig --region $(region) --name $(cluster)

set_namespace:
	@kubectl config set-context --current --namespace=$(env)

add_prerequisites:
	cd ../prerequisites
	@helm -n kube-system install shieldrule-prerequisites -f values-prerequisites-$(env).yaml .
	cd ../shieldrule

delete_prerequisites:
	cd ../prerequisites
	@helm -n kube-system uninstall shieldrule-prerequisites
	cd ../shieldrule

# TODO keeping this here for other environments to easily wipe the old alb controller
delete_alb_controller:
	@helm -n kube-system delete aws-load-balancer-controller

rollout:
	@kubectl -n $(env) rollout restart deployment/shieldrule-$(service)
	@kubectl -n $(env) rollout status -w deployment/shieldrule-$(service)

uninstall: delete_prerequisites
	@helm uninstall shieldrule -n $(env)

patch_ingress:
	@kubectl patch ingress $(ingress) -n $(env) -p '{"metadata":{"finalizers":[]}}' --type=merge

describe:
	@echo "deployments:"
	@kubectl get deployments -n $(env)
	@echo "pods:"
	@kubectl get pods -n $(env)
	@echo "services:"
	@kubectl get services -n $(env)
	@echo "ingress:"
	@kubectl get ingress -n $(env)

tail_api_logs:
	@kubectl -n $(env) logs -f deployment/shieldrule-api -c shieldrule-api --since=10m

monitor_load_balancer_controller_pods:
	@kubectl -n kube-system get deployments
	@kubectl -n kube-system get pods -l app.kubernetes.io/instance=aws-load-balancer-controller

reboot_load_balancer_controller_pods:
	@kubectl -n kube-system delete pods -l app.kubernetes.io/instance=aws-load-balancer-controller

get_alb_controller_pod_logs:
	@kubectl -n kube-system logs -l app.kubernetes.io/instance=aws-load-balancer-controller

reinstall_load_balancer_controller:
	@helm uninstall aws-load-balancer-controller -n kube-system
	@helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
     -n kube-system \
     --set clusterName=$(env)-eks \
     --set serviceAccount.create=false \
     --set serviceAccount.name=aws-load-balancer-controller