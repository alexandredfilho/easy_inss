# User Registration Project

Este projeto é uma aplicação que permite o cadastro de Proponentes para o cálculo de alíquota do INSS com base na tabela disponibilizada pelo órgão responsável em sua [página oficial](https://www.gov.br/inss/pt-br/direitos-e-deveres/inscricao-e-contribuicao/tabela-de-contribuicao-mensal).

## Funcionalidades

- Cadastro de usuários com Devise
- Login e Logout
- Autenticação de usuários
- Criação de `Proponents` com `Endereço`, `Salário` e `Telefones`
- Processamento de métricas de desconto do INSS para `Proponents` com Sidekiq/Redis com base na tabela do INSS

## Tecnologias Utilizadas

- Ruby on Rails
- Devise (para autenticação de usuários)
- Docker (para criação de um ambiente de desenvolvimento isolado)
- PostgreSQL (banco de dados)
- Sidekiq (para enfileirar e processar jobs)
- Redis (para gerenciamento de filas no Sidekiq)
- Bootstrap para o frontend
- charts.js para a exibição de gráfico
- Kaminari para paginação
- Rubocop para organização e qualidade do código
- Rubycritc tambem para qualidade de códgido
- SimplCov para validar a porcentagem de cobertura de testes

## Requisitos

- Docker
- Docker Compose
- Redis (para lidar com as filas do Sidekiq)
- PostgreSQL

## Como Configurar o Ambiente de Desenvolvimento

Siga os passos abaixo para configurar o ambiente de desenvolvimento localmente usando Docker.

### 1. Clone o repositório

Clone o repositório para o seu ambiente local:

```bash
git clone git@github.com:alexandredfilho/easy_inss.git

cd easy_inss
```

### 2. Para o ambiente de desenvolvimento

```bash
docker compose run --rm easy_inss bin/rails db:drop db:create db:migrate db:seed
```
### 2.1 Em seguida

```bash
docker compose up
```

### 2.2 Credenciais para testar a aplicação na web
`admin@domain.com` `VerySecure@2024`

### 3. Para o ambiente de testes
```bash
docker compose -f docker-compose.yml -f docker-compose.test.yml run --rm easy_inss bin/rails db:drop db:create db:migrate
```

### 3.1 Em seguida
```bash
docker compose -f docker-compose.yml -f docker-compose.test.yml run --rm easy_inss bundle exec rspec
```

Ao término da execução dos testes, será exibida a porcentagem de cobertura de testes para esta aplicação.
