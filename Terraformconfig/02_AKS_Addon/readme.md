# Add on installation

This configuration deploys add on on AKS through null resource and provisionner.
**It requires that the az cli is logged on and that the appropriate subscription is set**

To use the configuration locally, copy paste the file `backend.hcl.example` and rename it `backend.hcl`

Fill in the file so that all the values are defined

To initialize the configuration, run the following command:  
  
```bash

terraform init -backend-config="./backend.hcl"

```

To apply the configuration, run the following command:  
  
```bash

terraform apply

```
