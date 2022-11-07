[![Blog](https://img.shields.io/website?down_color=blue&down_message=infrati.dev&label=Blog&logo=ghost&logoColor=green&style=for-the-badge&up_color=blue&up_message=infrati.dev&url=https%3A%2F%2Finfrati.dev)](https://infrati.dev)

## 📋 infratidev

### Explicação detalhada dos processos executados no Terraform Cloud (HCP)
  - [Terraform Cloud CLI-driven](terraform-cloud-cli-driven/)
  - [Terraform Cloud Github Integration](terraform-cloud-github/)

### Estrutura do terraform provisionada para exemplo. 

Criação de três servidores web em três zonas de disponibilidade ```[us-east-1a,us-east-1b,us-east-1c]```, com domínio próprio ```infracode.sres.dev ```configurado no Route53 direcionando as requisições para o ALB (Application Load Balancer) utilizando TLS nas requisições entre usuário e alb. Nesse exemplo, os três servidores estão em subnets públicas com EIP alocados.

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

#### Para Terraform Cloud CLI-driven

~~~
  cloud {
    organization = "andrei"

    workspaces {
      name = "terraform-cloud-aws-cli"
    }
  }
~~~

#### Para Terraform Cloud Github Integration

~~~
  cloud {
    organization = "andrei"

    workspaces {
      name = "terraform-cloud-aws-github"
    }
  }
~~~
  
<br>

[![Blog](https://img.shields.io/website?down_color=blue&down_message=infrati.dev&label=Blog&logo=ghost&logoColor=green&style=for-the-badge&up_color=blue&up_message=infrati.dev&url=https%3A%2F%2Finfrati.dev)](https://infrati.dev)




