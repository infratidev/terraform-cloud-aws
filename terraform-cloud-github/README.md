[![Blog](https://img.shields.io/website?down_color=blue&down_message=infrati.dev&label=Blog&logo=ghost&logoColor=green&style=for-the-badge&up_color=blue&up_message=infrati.dev&url=https%3A%2F%2Finfrati.dev)](https://infrati.dev)

## 📋 infratidev
 
### Terraform Cloud Control Version Workflow

O uso do Terraform Cloud integrado com o Github ***Terraform Cloud Version Control workflow***.

#### Requirements

* Conta criada na HCP
  * Link para criação da conta: [Criação da conta](https://app.terraform.io/session), testes realizados utilizando o plano gratuito: [Free Plan](https://app.terraform.io/app/andrei/settings/billing/plans)
* API token criado na HCP. [Link documentação](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/users#api-tokens)
* AWS_SECRET_ACCESS_KEY e AWS_ACCESS_KEY_ID gerados na AWS e configurados no HCP em [variáveis de ambiente](https://developer.hashicorp.com/terraform/language/values/variables#environment-variables) aplicadas como [sensíveis](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables/managing-variables#sensitive-values) dentro do workspace.
* Organização e workspaces criadas na HPC.
  * Nesse exemplo o nome da organização é: ```andrei```
  * Workspace criada:
    * terraform-cloud-aws-github

#### Estrutura do terraform provisionada para exemplo. 

Criação de três servidores web em três zonas de disponibilidade ```[us-east-1a,us-east-1b,us-east-1c]```, com domínio próprio ```infracode.sres.dev ```configurado no Route53 direcionando as requisições para o ALB (Application Load Balancer) utilizando TLS nas requisições entre usuário e o alb. Nesse exemplo, os três servidores estão em subnets públicas com EIP alocados.

~~~
.
├── acm.tf
├── alb.tf
├── data.tf
├── ec2.tf
├── network.tf
├── output.tf
├── provider.tf
├── route53.tf
├── sg.tf
└── variables.tf
~~~

Configuração do remote backend

~~~
  cloud {
    organization = "andrei"

    workspaces {
      name = "terraform-cloud-aws-github"
    }
  }
~~~

### Execuções

#### Ao abrir um PR no github com a opção (Speculative Plans) habilitado no terraform cloud, automaticamente é realizado um `plan` para testar as alterações durante o pull request.

**Obs:** Speculative Plans não aparecem na lista de execuções no workspace

![01-terraform-cloud.png](../images/github/01-terraform-cloud.png)

`plan` em execução durante a abertura do PR

![02-terraform-cloud.png](../images/github/02-terraform-cloud.png)

`plan` executado com sucesso

![03-terraform-cloud.png](../images/github/03-terraform-cloud.png)
![04-terraform-cloud.png](../images/github/04-terraform-cloud.png)


PR aprovado o merge é realizado na main.

![05-terraform-cloud.png](../images/github/05-terraform-cloud.png)

Ao realizar o merge na `main` o `plan` entra em execução novamente no HCP.

![06-terraform-cloud.png](../images/github/06-terraform-cloud.png)

`plan` executado com sucesso

![07-terraform-cloud.png](../images/github/07-terraform-cloud.png)

Aprovação do `apply` manualmente nesse caso, pode ser automático também.

![08-terraform-cloud.png](../images/github/08-terraform-cloud.png)

`apply` em execução

![09-terraform-cloud.png](../images/github/09-terraform-cloud.png)
![10-terraform-cloud.png](../images/github/10-terraform-cloud.png)

`apply` executado com sucesso

![11-terraform-cloud.png](../images/github/11-terraform-cloud.png)
![12-terraform-cloud.png](../images/github/12-terraform-cloud.png)

output gerado do terraform

![13-terraform-cloud.png](../images/github/13-terraform-cloud.png)

### Estrutura provisionada com sucesso!!!

ALB criado:

~~~
"ALB-888151020.us-east-1.elb.amazonaws.com"
~~~

Endereços de cada instancia nas zonas de disponibilidades.

~~~
"Instance-infracode-0" = "18.211.161.124"
"Instance-infracode-1" = "34.227.55.57"
"Instance-infracode-2" = "34.226.13.35"
~~~

Realizando algumas requisições para o fqdn criado, validando o direcionamento para o ALB no route53.

![14-terraform-cloud.png](../images/github/14-terraform-cloud.png)
![15-terraform-cloud.png](../images/github/15-terraform-cloud.png)
![16-terraform-cloud.png](../images/github/16-terraform-cloud.png)

Caso necessite realizar a remoção dos recursos. Dentro das configurações do workspace, existe a opção ```Destruction and Deletion```.

![17-terraform-cloud.png](../images/github/17-terraform-cloud.png)

Estrutura removida com sucesso!!

<br>

[![Blog](https://img.shields.io/website?down_color=blue&down_message=infrati.dev&label=Blog&logo=ghost&logoColor=green&style=for-the-badge&up_color=blue&up_message=infrati.dev&url=https%3A%2F%2Finfrati.dev)](https://infrati.dev)




