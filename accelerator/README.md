# Usage

## 0. Prerequisites

**Permissions:**

- "Owner" on the subscription
- "Owner" on the tenant management group

**Roles**

Elevate your - logged in - user:

```sh
az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2017-05-01"
```

then log out and log back in

Assign owner on the subscription(s) and management groups

```sh
 az role assignment create --assignee "6e3feaa6-d3d6-437b-b6e3-1afc733750d7" --role "Owner" --scope "/"

az role assignment create --assignee "6e3feaa6-d3d6-437b-b6e3-1afc733750d7" --role "Owner" --scope "/subscriptions/f45a9cdc-bf42-4cec-8394-19cf4b3dbbca"
```

**If you need to remove the managemenet group**

```sh
az account management-group delete --name alzroot
```

## 1. Update `inputs.yaml`

See instructions: <https://azure.github.io/Azure-Landing-Zones/accelerator/userguide/2_start/terraform-local/>

## 2. Copy and upate `platform-landing-zone.tfvars`

```powershell
# command is relativel to this location
cd .\accelerator

Copy-Itemm .\config\platform-landing-zone_tfvars_sample .\config\platform-landing-zone.tfvars
```

Edit and update `.\config\platform-landing-zone.tfvars`

## 3. Bootstrap LZ

```powerhsell
# command is relativel to this location
cd .\accelerator

deploy-Accelerator -inputs .\config\inputs.yaml, .\config\platform-landing-zone.tfvars -output .\output\
```

## 4. Deploy LZ

```powershell
# command is relativel to this location #!
cd .\accelerator\output\local-output

./scripts/deploy-local.ps1
```
