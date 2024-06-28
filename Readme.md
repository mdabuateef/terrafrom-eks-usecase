Automate K8 EKS cluster setup using terraform
create a 

dev env
terraform -chdir=C:\abuateef\azure\terraform\Dev apply -var-file="c:/abuateef/azure/terraform/var/dev.tfvars"
aws eks update-kubeconfig --name my-cluster --region ap-south-1

kubectl config get-contexts

kubectl config use-context arn:aws:eks:ap-south-1:123456789012:cluster/my-cluster

kubectl get nodes

Prod env 
terraform -chdir=C:\abuateef\azure\terraform\Prod apply -var-file="c:/abuateef/azure/terraform/var/prod.tfvars"
aws eks update-kubeconfig --name my-cluster --region ap-south-1

kubectl config get-contexts

kubectl config use-context arn:aws:eks:ap-south-1:123456789012:cluster/my-cluster

kubectl get nodes

