## **W2Y Auth Service**

![W2Y logo](https://github.com/daniloalvescosta/w2y_auth_service/blob/main/app/assets/images/w2y.png)

Serviço de autenticação do sistema W2Y, para executar ele é simples:

    docker compose build
    docker compose up


Caso queira rodar a suit de testes individualmente:

    docker-compose run --rm test

Caso queira rodar as migrations individualmente:
docker compose exec web rails db:create
docker compose exec web rails db:migrate
