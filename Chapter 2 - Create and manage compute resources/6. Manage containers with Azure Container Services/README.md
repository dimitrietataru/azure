# MANAGE CONTAINERS WITH AZURE CONTAINER SERVICES (ACS)



### Implement Azure Container Registry
```bash
#Create a resource group
az group create
    --name ContainersRG
    --location westus2

# Create the Azure Container Registry
az acr create
    --resource-group ContainersRG
    --name ExamRefRegistry
    --sku Basic
    --admin-enabled true

# Login to the registry
az acr login
    --name ExamRefRegistry
    --username ExamRefRegistry
    --password <passwordfound in azure portal>
    
#List the name of your ACR Server
az acr list
    --resource-group ContainersRG
    --query "[].{acrLoginServer:loginServer}"
    --output table
```



### Deploy a Kubernetes cluster in ACS
```bash
az acs create
    --orchestrator-type kubernetes
    --resource-group ContainersRG
    --name ExamRefK8sCluster
    --generate-ssh-keys
    --agent-count 1
    
#Configure the kubectl
az acs kubernetes get-credentials
    --resource-group=ContainersRG
    --name=ExamRefK8sCluster
    
#Verify connection to the cluster
kubectl get nodes
```
