# System requirements:

* Ruby version 2.6.0
* Rails version ~> 5.0.7


# Installation

Clone the project:

    git clone https://github.com/WlademirRenan/stock_managment.git

Run:

    bundle install

    rails db:create

    rails db:migrate

The Product have the following params:
* name;
* cost_price;

The Store have the following params:
* name;
* address;

The StockItem have the following params:
* product_id
* store_id
* quantity

# Url on heroku:

https://stock-managment-a.herokuapp.com


# Endpoints:

`GET  /api/v1/products/:id` => Show Product

`POST  /api/v1/product` => Create Product

`PATCH  /api/v1/products/:id` => Update Product

`DELETE /api/v1/products/:id` => Delete Product


`GET    /api/v1/stores/:id` => Show Store

`POST   /api/v1/stores` => Create Store

`PATCH  /api/v1/stores/:id` => Update Store

`DELETE /api/v1/stores/:id` => Delete Store


`POST   /api/v1/stock_items` => Create StockItem

`PATCH  /api/v1/stock_items` => Update StockItem

`DELETE /api/v1/stock_items` => Delete StockItem


# Request Examples:

    Create Product

POST /api/v1/product?name=ProductX&amp;cost_price=10.0 HTTP/1.1

Host: localhost:3000

    Show Product

GET /api/v1/products/1?product_id=1&amp; = HTTP/1.1

Host: localhost:3000

    Update Product

PATCH /api/v1/products/1?product_id=1&amp;name=Prod21&amp;cost_price=1.0 = HTTP/1.1

Host: localhost:3000

    Delete Product

DELETE /api/v1/products/1?product_id=1&amp; = HTTP/1.1

Host: localhost:3000



    Create Store

POST /api/v1/store?name=storeX&amp;address=rua HTTP/1.1

Host: localhost:3000

    Show store

GET /api/v1/stores/1?store_id=1&amp; = HTTP/1.1

Host: localhost:3000

    Update store

PATCH /api/v1/stores/1?store_id=1&amp;name=Prod21&amp;address=rua2 = HTTP/1.1

Host: localhost:3000

    Delete store

DELETE /api/v1/stores/1?store_id=1&amp; = HTTP/1.1

Host: localhost:3000

    Create StockItem

POST /api/v1/stock_items?product_id=1&amp;store_id=1&amp;quantity=10.0 HTTP/1.1

Host: localhost:3000

    Add Quantity

PATCH /api/v1/stock_items?product_id=1&amp;store_id=1&amp;quantity=1.0 HTTP/1.1

Host: localhost:3000

    Remove Quantity

DELETE /api/v1/stock_items?product_id=1&amp;store_id=1&amp;quantity=1.0 HTTP/1.1

Host: localhost:3000


# Introdução

Utilizei o patern de service object aplicando um conceito de ddd, onde todos os services são operações de um recurso, por exemplo, no produto temos os services de create, update, select e delete, dessa forma fica bem fácil para implementar um sistema assíncrono(sidekiq, activejob, rabbitMQ, SQS/SNS, entre outros), visando performance e alta disponibilidade, também utilizei transactions na parte de fazer a inseção/remoção do estoque me preocupando com a concorrencia

Criei uma pasta para v1 da api, pois quando for necessário fazer uma v2, fique facil de alterar e manter a v1 enquanto a v2 é implementada e homologada

Como na descriçao do teste não estava especificado para validar estoque negativo, optei por permitir e não fiz validações para esse cenário


# Melhorias:

* Utilizar serializer nos models para retornar a classe já formatada
* Sistema assíncrono para entradas de dados
* Aumentar cenários de testes
* Implementar factorybot e faker para os testes
* Implementar cache para todas as consultas
* Implementar limpeza de cache do item quando atualizado
* Implementar autenticação para requisições na api