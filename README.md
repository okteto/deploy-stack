# GitHub Actions for Okteto Cloud

## Automate your development workflows using Github Actions and Okteto Cloud
GitHub Actions gives you the flexibility to build an automated software development workflows. With GitHub Actions for Okteto Cloud you can create workflows to build, deploy and update your applications in [Okteto Cloud](https://cloud.okteto.com).

Get started today with a [free Okteto Cloud account](https://cloud.okteto.com)!

## Github Action for Deploying a Stack in Okteto Cloud

You can use this action to [deploy a stack](https://okteto.com/docs/cloud/stack) in Okteto Cloud as part of your automated development workflow.

## Inputs

### `namespace`

The Okteto namespace to use. If not specified it will use the namespace specified by the `namespace` action.

### `name`

The name of the stack. If not specified it will use the one in your manifest file.

### `build` 

Set to `true` to build the images before deploying your stack.

### `file` 

The path to the manifest file. If not specified, it will default to `docker-compose.yaml` or ` okteto-stack.yaml`.

### `working-directory`

The working directory of the action. Defaults to the root folder of the repo.

## Example usage

This example runs the login action and then creates the stack

```yaml
# File: .github/workflows/workflow.yml
on: [push]

name: example

jobs:

  devflow:
    runs-on: ubuntu-latest
    steps:
    
    - uses: okteto/login@master
      with:
        token: ${{ secrets.OKTETO_TOKEN }}
    
    - uses: okteto/namespace@master
    
    - name: "Create stack"
      uses: okteto/deploy-stack@master
      with:
        build: "true"
```



## Advanced usage

 ### Custom Certification Authorities or Self-signed certificates

 You can specify a custom certificate authority or a self-signed certificate by setting the `OKTETO_CA_CERT` environment variable. When this variable is set, the action will install the certificate in the container, and then execute the action. 

 Use this option if you're using a private Certificate Authority or a self-signed certificate in your [Okteto Enterprise](http://okteto.com/enterprise) instance.  We recommend that you store the certificate as an [encrypted secret](https://docs.github.com/en/actions/reference/encrypted-secrets), and that you define the environment variable for the entire job, instead of doing it on every step.


 ```yaml
 # File: .github/workflows/workflow.yml
 on: [push]

 name: example

 jobs:
   devflow:
     runs-on: ubuntu-latest
     env:
       OKTETO_CA_CERT: ${{ secrets.OKTETO_CA_CERT }}
     steps:
    
     - uses: okteto/login@master
       with:
         token: ${{ secrets.OKTETO_TOKEN }}
    
     - uses: okteto/namespace@master
    
     - name: "Create stack"
       uses: okteto/deploy-stack@master
       with:
         build: "true"
```