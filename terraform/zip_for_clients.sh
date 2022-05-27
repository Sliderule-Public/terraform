#! /bin/bash

rm app.zip || echo "Old zip already removed."

zip -r app.zip . \
-x gcp/\* \
-x **.terraform/\* \
-x **grafana-*/\* \
-x *.tfvars \
-x **/terraform.tfstate.d/\* \
-x temp/\* \
-x shieldrule-specific/\* \
-x **/.terraform.lock.hcl \
-x zip_for_clients.sh
