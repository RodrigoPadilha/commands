***

# 1. Containers
##  Executar containers
### Listar containers criados
```
docker ps       // lista containers em execução
docker ps -a    // lista todos containers criados
```

### Faz doanload de imagem, cria e executa container 
```
docker run NOME_DA_IMAGEM
docker run NOME_DA_IMAGEM COMANDO_PARA_EXECUTAR
docker run -d NOME_DA_IMAGEM    // Inicia sem travar o terminal
```
`-d`: detached

### Executar container com nome
```
docker run -d -P --name MEU_CONTAINER NOME_DA_IMAGEM
```

### Executar container com mapeamento de portas
```
docker run -d -p 8080:80 NOME_DA_IMAGEM
```

`-p`: faz mapemento de portas **external_port** : **internal_port**

```
docker run -d -P dockersamples/static-site
```
`-P`: faz mapeamento de porta **aleatória** : 

### Iniciar, parar e pausar um container 
```
docker start ID_CONTAINER
docker stop ID_CONTAINER
docker stop ID_CONTAINER -t=0
docker stop ID_CONTAINER -t 0       // Parar um container
docker stop -t 0 $(docker ps -q)    // Parar vários containers
```
`-t`: tempo para pausar container

```  
docker pause ID_CONTAINER
docker unpause ID_CONTAINER
```

## Remover containers
```
docker rm ID_CONTAINER                          // Excluir um container
docker rm ID_CONTAINER --force
docker container prune                          // Excluir todos containers
docker rm $(docker container ps -aq) --force    // Remover todos os containers
```

## Executar um comando em um container que está em execução
```
docker exec -it ID_CONTAINER bash   // Acessar de modo iterativo (terminal do linux)
```
`-it`: iterativo

`bash`: comando para executar o terminal 


## Exibir informações de um container
```
docker inspect  ID_CONTAINER    // Exibe diversas informações sobre um container
docker port     ID_CONTAINER    // Exibir mapeamento de portas de um container
```

***

# 2. Imagens
```
docker images                       // Lista imagens baixadas 
docker pull NOME_DA_IMAGEM          // Download de imagem do 
docker rmi  NOME_DA_IMAGEM          // Exclui uma imagem 
docker history  NOME_DA_IMAGEM      // Exibe camadas que compõe uma imagem
```

***

# 3. Docker File
Docker file: build 
        -> Imagem: run 
                -> conatiner
```
    FROM Node:14
    WORKDIR /app-node
    ARG PORT_BUILD=6000     // Utilzado na construção da imagem
    ENV PORT=PORT_BUILD     // Utilizado nas variáveis de ambiente do conatiner
    EXPOSE 3000             // Documenta a porta a ser utilizada
    COPY . .                // PATH_LOCAL  PATH_CONTAINER
    RUN npm install
    ENTRYPOINT npm start
```

***

# 4. Docker Hub
O nome da imagem(Repository) precisa ser no padrão do docker hub:
`LOGIN_DOCKER_HUB/NOME_DA_IMAGEM`
Exemplo: `aluradocker/app-node:1.0`
```
docker login -u SEU_USUARIO     // Faz login no Docker Hub
docker push NOME_DA_IMAGEM      // Faz upload da imagem para docker hub
```

***

# 5. Persistindo dados
## Bind Mount
> **`!!!ATENÇÃO!!!`** 
>
> A forma correta/indicada de configurar a persistência de dados é utilizando Volumes ao invés de diretórios e pastas
```
docker run -it -v /home/rodrigo/volume-docker:/app NOME_DA_IMAGEM bash
```
`-v`: faz mapemento de um diretório **external_path** : **internal_path**

```
docker run -it --mount type=bind, source=/home/rodrigo/volume-docker,target=/app NOME_DA_IMAGEM bash
```
`--mount`: indica que será utilizado o mapemento de um diretório 

`type`: tipo de mapeamento

`source`: indica um diretório externo (do host)

`target`: indica um diretório interno (do container)


## Volumes
> Volumes são gerenciados pelo Docker e independem da estrutura de pastas do sistema.
```
docker volume ls                                            // Listar volumes
docker volume create NOME_DO_VOLUME                         // Criar um volume
docker run -it -v NOME_DO_VOLUME:/app NOME_DA_IMAGEM bash   // Configura Volume no container
docker run -it --mount, source=NOME_DO_VOLUME,target=/app NOME_DA_IMAGEM bash   // Configura Volume no container
```
> Os dados são armazenaos no diretório do docker:
> `/var/lib/docker/volumes/NOME_DO_VOLUME/_data`
## TMPFS
```
docker run -it --tmpfs=/app NOME_CONTAINER bash
```
`--tmpfs`: cria uma pasta temporária que salva os dados no host mas não será acessível quando outro container for criado

***

# 6. Network
```
docker network ls       // Lista redes existentes do docker
```


## Rede Bridge
```
docker network create --driver bridge NOME_MINHA_REDE   // Cria uma rede bridget

docker run -it --name MEU_CONTAINER --network create --driver bridge NOME_MINHA_REDE    // Cria container e inclui em uma rede
``` 
* Utilizar nome do container que é a informação maios estável do container
* A rede bridget provê a resoluçãod e DNS entre os containers, desta forma os containers podem se comunicar através do nome do container


## Rede Host
* A rede host remove o isolamento entre o container e o sistema;
* Quando um container é criado com este driver, não é encessário fazer um mapeamento de portas, pois utiliza a interface do host para se comunicar;
* Isso impede que duas aplicações sejam executadas na mesma máquina caso ambas utilizem a mesma porta.


## Rede Null
* A rede none remove a interface de rede;
* Um container é criado sem uma interface de rede.

**Declarar variável de ambienbte**
    `docker run -d -P -e AUTHOR="Rodrigo Padilha dos santos" dockersamples/static-site`
    
## Exemplo de Implementação de Containers em Rede
### 1) Criar Network
```
docker network create --driver bridge minha-bridge
```
### 2) Criar container do banco de dados
> Vai adicionar na Rede criada na etapa anterior
> Vai setar o nome par ao cotainer no container, esse nome deverá ser configurado na configuração da connection do banco
```
docker run -d --network minha-bridge --name meu-mongo mongo:4.4.6
```
### 3) Criar container da aplicação
> Vai adicionar na rede criada na etapa 1
> Vai setar o nome no container
> Vai mapear a porta para acesso da aplicação
```
docker run -d --network minha-bridge --name alurabooks –p 3000:3000 aluradocker/alura-books:1.0
```

***
# Docker Compose
> **`!!!ATENÇÃO!!!`** 
> O docker compose é uma ferramenta de coordenação de containers
> que precisa ser instalada a parte do docker:
<https://docs.docker.com/compose/install/>

```
docker-compose up
docker-compose down
docker-compose ps
```








##########################
#### Comandos Básicos ####
##########################


# Iniciar Serviço no ArchLinux
    systemctl start docker.service

??? Se não executar o run com a flag -it o container não fica com status iniciado?

docker pull centos                          -> Baixa imagem
docker run -it centos                       -> gera container
docker start ID_CONTAINER                   -> inicia container
docker exec -i -t ID_CONTAINER /bin/bash    -> Acessa terminal após container iniciado (ao sair com Ctrl+D o container continua iniciado )
docker stop ID_CONTAINER                    -> para container
docker start ID_CONTAINER -a -i             -> iniciar container e acessa terminal (ao sair com Ctrl+D o container para)


# Exibe a versão do Docker
    docker version

# Verifica se o docker está rodando
    sudo systemctl status docker

# Cria um container e inicia
    docker run NOME_DA_IMAGEM       // prende o terminal pois o processo do container é iniciado
    docker run -d NOME_DA_IMAGEM    // cria container e não bloqueia terminal



# Iniciar container
    docker start ID_DO_CONTAINER

    ** Após executar o run o container vai para o ESTADO de PARADO,
        o mesmo só fica em execução quando é acessado via modo interativo (Flag -it)
        para que o estado deste mude é necessário executar o comando:  'docker start ID_CONTAINER'

# Parar um container
    docker stop ID_DO_CONTAINER

# Acessar terminal de um container e acessar o terminal do container
    docker start -a -i ID_DO_CONTAINER

# Remover um container 
    docker rm NOME_DA_IMAGEM
    docker container prune  // Limpa todos os containers parados
    docker rmi images ID_DO_CONTAINER
    



# Efetua mapeamento de portas para o uso externo do container
    docker run -d -P NOME_DA_IMAGEM  // -P para mapear uma porta aleatória

# Efetua mapeamento de uma porta específica container
    docker run -d -p 12345:80 NOME_DA_IMAGEM    // -p porta_para_acesso_extern:porta_interna_do_container

# Lista portas mapeadas
    docker port

# Exibe IP dos containers ativos
    docker-machine ip

# Nomear um container
    docker-run -d -P --name meu-container NOME_DA_IMAGEM    // --name é o parametro para setar um nome no container

# Criar Variável de ambiente
    docker run -d -P -e AUTHOR = "Rodrifo Padilha dos Snatos" NOME_DA_IMAGEM    // -e nome_da_variavel

# Retorna lista de IDs dos containers que estão rodando
    docker ps -q

# Logs de um container (tail no arquivo de logs)
    docker logs -f ID_CONTAINER

# Parar todos os containers que estão rodando
    docker stop -t 0 $(docker ps -q) // $(algum_comando) executa o que está dentro dos parenteses antes




# Carregar container iniciando no diretório
    docker run -p 8080:3000 -v "C:\Users\rodrigo\Desktop\miha-pasta:/var/www" -w "/var/www" node npm start // flag w direciona para iniciar em uma pasta específica
    docker run -p {PORTA:PORTA} -v "{CAMINHO_HOST:CAMINHO_CONTAINER}" -w "{PASTA_QUE_O_CONTAINER_VAI_STARTAR}" {COMANDO_PARA EXECUTAR_NO_CONTAINER}
    docker run -v "CAMINHO_VOLUME" NOME_DA_IMAGEM   // cria um volume no respectivo caminho do container.

    docker run -p 1234:3000 -v "/Users/rodripsa/Projetos/Exemplos/ApiFotosNode:/usr/src/app" -w "/usr/src/app" -d rodrigo/apiteste npm start

# Interpolando comandos
    docker run -p 8080:3000 -v "$(pwd):/var/www" -w "/var/www" node npm start // flag w direciona para iniciar em uma pasta específica

# Exibir informações do container
    docker inspect NOME_DO_CONTAINER


## VOLUMES


# Listar volumes 
    docker volumes ls

# Criando Volumes (FORMA ANTIGA, a documentação indica para usar o "--mount")
    -> Mapeia uma pasta específica do Host para Container (BindMount)
        Armazena em um caminho absoluto do Host e em uma pasta dentro do container
            docker ID_CONTAINER run -it -v /home/rodrigo/minha_pasta:/pasta_do_container

    -> Mapeia um diretório default do docker do Host para Container (Volume)   
        Armazena em uma pasta específica do Docker dentro do Host
            docker ID_CONTAINER run -it -v /pasta_do_container

    -> Cria volume nomeado para usar no Container ()
        Armazena em uma pasta específica do Docker dentro do Host mas aparece na lista de volumes (docker volumes ls)
            docker volume create meu_volume
            docker ID_CONTAINER run -it -v meu_volume:/pasta_do_container


# Criando volumes com --MOUNT
    - target: diretório do container
    - source

    # Bind mount
        docker ID_CONTAINER run -it --mount type=bind, source=/home/rodrigo/meu-dir/, target=/var/www

    # Volume Nomeado
        docker ID_CONTAINER run -it --mount type=bind, source=meu-volume, target=/var/www

    # Temp em memória RAM (apenas no linux)
        docker ID_CONTAINER run -it --mount type=tmpfs, target=/var/www




####################
#### DOCKERFILE ####
####################
    Responsável por criar a imagem de um container Docker, incluindo as configurações de rede e portas, pastas, diretórios, etc. Tabém pode se basear em outra imagem padrão disponível na Docker

 # cria uma imagem a partir de um Dockerfile.
    docker build -f Dockerfile .    (NÃO ESQUECER DO PONTO FINAL)

# constrói e nomeia uma imagem não-oficial informando o caminho para o Dockerfile.
    docker build -f CAMINHO_DOCKERFILE/Dockerfile -t NOME_USUARIO/NOME_IMAGEM . (NÃO ESQUECER DO PONTO FINAL)

# inicia o processo de login no Docker Hub.
    docker login

 # envia a imagem criada para o Docker Hub.
    docker push NOME_USUARIO/NOME_IMAGEM

# baixa a imagem desejada do Docker Hub.
    docker pull NOME_USUARIO/NOME_IMAGEM

#################
#### NETWORK ####
#################
# mostra o ip atribuído ao container pelo docker (funciona apenas dentro do container).
    hostname -i

# cria uma rede especificando o driver desejado.
    docker network create --driver bridge NOME_DA_REDE

# cria um container especificando seu nome e qual rede deverá ser usada.   
    docker run -it --name NOME_CONTAINER --network NOME_DA_REDE NOME_IMAGEM

#### docker run -d --name meu-mongo --network rede-producao mongo
#### docker run -d -p 3000:3000 --name minha-aplicacao --network rede-producao meu_contianer
#### docker inspect minha_rede



########################
#### DOCKER COMPOSE ####
########################
    Auxilia a automatização de criação e gerenciamento dos containers. Orquesttração
    Com um único comando é possívelk , subir os containers, criar load-balance, server arquivos státicos e ligar todos na mesma rede

    # Não é instalado por padrão com o Docker, após instalar é necessário dar as permissões para execução do docker-compose
        sudo chmod +x /usr/local/bin/docker-compose

    # Ciar arquivo docker-compose.yml                        
        version: '3'                                        // setar a versão e usar identação, assim como em Python
        services:                                           // criar os servives, cada container será um service
            nginx:  
                build:                                      // buildar a imagem com base no dockerfile:zxc
                    dockerfile: ./docker/nginx.dockerfile
                    context: .                              // PASTA em que o container vai Iniciar
                image: douglasq/nginx                       // NOME da Imagem
                container_name: nginx                       // NOME do container
                ports:                                      // Libera porta e redireciona
                    - "80:80"
                networks:                                   // Coloca o container em uma REDE
                    - production-network
                depends_on:                                 // Precisa que os serviços/container node2, node2 e node3 tenham sido instanciados antes
                    - "node1"
                    - "node2"
                    - "node3"

            mongodb:                                        // CRIA Container com mongo
                image: mongo
                networks: 
                    - production-network

            node1:
                build:
                    dockerfile: ./docker/alura-books.dockerfile
                    context: .
                image: douglasq/alura-books
                container_name: alura-books-1
                ports:
                    - "3000"
                networks: 
                    - production-network
                depends_on:                                 // DEPENDE do container "mongodb", ou seja, precisa que este seja criado antes
                    - "mongodb"

            node2:
                build:
                    dockerfile: ./docker/alura-books.dockerfile
                    context: .
                image: douglasq/alura-books
                container_name: alura-books-2
                ports:
                    - "3000"
                networks: 
                    - production-network
                depends_on:
                    - "mongodb"

            node3:
                build:
                    dockerfile: ./docker/alura-books.dockerfile
                    context: .
                image: douglasq/alura-books
                container_name: alura-books-3
                ports:
                    - "3000"
                networks: 
                    - production-network
                depends_on:
                    - "mongodb"

        networks: 
            production-network:
                driver: bridge
    
    # Cria as imagens dos containers
        docker-conpose build
    
    # Starta todos os containers conforme arquivo do Compose
        docker-compose up
        docker compose up -d // libera o terminal para digitação
    
    # Lista os containers/serviços que estão no ar
        docker-compose ps

    # Para os containers e remove as imagens
        docker-compose down

    # Executar PING 
        docker exec -it nome_do_container ping nome_container_2
        docker exec -it ip_do_container ping ip_container_2





############################################
#### PRINCIPAIS COMANDOS DO CURSO ALURA ####
############################################
Comandos relacionados às informações
    docker version - exibe a versão do docker que está instalada.
    docker inspect ID_CONTAINER - retorna diversas informações sobre o container.
    docker ps - exibe todos os containers em execução no momento.
    docker ps -a - exibe todos os containers, independentemente de estarem em execução ou não.

Comandos relacionados à execução
    docker run NOME_DA_IMAGEM - cria um container com a respectiva imagem passada como parâmetro.
    docker run -it NOME_DA_IMAGEM - conecta o terminal que estamos utilizando com o do container.
    docker run -d -P --name NOME dockersamples/static-site - ao executar, dá um nome ao container.
    docker run -d -p 12345:80 dockersamples/static-site - define uma porta específica para ser atribuída à porta 80 do container, neste caso 12345.
    docker run -v "CAMINHO_VOLUME" NOME_DA_IMAGEM - cria um volume no respectivo caminho do container.
    docker run -it --name NOME_CONTAINER --network NOME_DA_REDE NOME_IMAGEM - cria um container especificando seu nome e qual rede deverá ser usada.

Comandos relacionados à inicialização/interrupção
    docker start ID_CONTAINER - inicia o container com id em questão.
    docker start -a -i ID_CONTAINER - inicia o container com id em questão e integra os terminais, além de permitir interação entre ambos.
    docker stop ID_CONTAINER - interrompe o container com id em questão.

Comandos relacionados à remoção
    docker rm ID_CONTAINER - remove o container com id em questão.
    docker container prune - remove todos os containers que estão parados.
    docker rmi NOME_DA_IMAGEM - remove a imagem passada como parâmetro.

Comandos relacionados à construção de Dockerfile
    docker build -f Dockerfile - cria uma imagem a partir de um Dockerfile.
    docker build -f Dockerfile -t NOME_USUARIO/NOME_IMAGEM - constrói e nomeia uma imagem não-oficial.
    docker build -f Dockerfile -t NOME_USUARIO/NOME_IMAGEM CAMINHO_DOCKERFILE - constrói e nomeia uma imagem não-oficial informando o caminho para o Dockerfile.

Comandos relacionados ao Docker Hub
    docker login - inicia o processo de login no Docker Hub.
    docker push NOME_USUARIO/NOME_IMAGEM - envia a imagem criada para o Docker Hub.
    docker pull NOME_USUARIO/NOME_IMAGEM - baixa a imagem desejada do Docker Hub.

Comandos relacionados à rede
    hostname -i - mostra o ip atribuído ao container pelo docker (funciona apenas dentro do container).
    docker network create --driver bridge NOME_DA_REDE - cria uma rede especificando o driver desejado.



### EXEMPLOS


docker-compose exec marcomob_web_1 /bin/bash
docker-compose exec 9cbf1819126bcbd44b9359ae4b73d15b84beab7d9f20170e1e08a5d2a58c370b /bin/bash

docker-compose exec marcmob_web_1 /bin/bash
docker-compose exec marcomob_web_1 /bin/bash
docker-compose exec 9cbf1819126bcbd44b9359ae4b73d15b84beab7d9f20170e1e08a5d2a58c370b /bin/bash
docker-compose exec marcomob_web_1 /bin/bash

docker ps
docker ls
docker container ls
docker container ls -a
docker images ls -a
docker images ls
docker images ls -la
docker image ls -a
docker-compose exec marcomob_web_1 /bin/bash

docker build --help
docker build . -t marcomob-test
docker run marcomob-test -p 8000:8000
docker inspect 31eea0ce1f6f
docker exec 31eea0ce1f6f /bin/bash
docker exec marcomob_web /bin/bash
docker exec marcomob_web_1 /bin/bash
docker exec --help
docker exec marcomob_web_1 /bin/sh
docker-compose up
docker-compose down
docker-compose up -d
docker-compose exec 31eea0ce1f6f /bin/bash
docker-compose exec marcomob_web_1 /bin/bash
docker-compose exec 9e6acdde7913 /bin/bash
docker exec 9e6acdde7913 /bin/bash
docker-compose down
docker run -it -p 8000:8000 -m .:/code/ marcomob-test
docker run -it -p 8000:8000 -v .:/code/ marcomob-test
docker run -it -p 8000:8000 -v $PWD:/code/ marcomob-test /bin/bash
docker run -it -p 8000:8000 -v $PWD:/code/ marcomob-test
docker run -d -p 8000:8000 -v $PWD:/code/ marcomob-test
docker kill df12688fff38 3838f57d163b 9cbf1819126bcbd44b9359ae4b73d15b84beab7d9f20170e1e08a5d2a58c370b
docker run -it -p 8000:8000 -v $PWD:/code/ marcomob-test /bin/bash

#Sobe container
docker run -d -p 8000:8000 -v $PWD:/code/ marcomob_web

#### Conectar Conteiner ####
#https://imasters.com.br/desenvolvimento/obter-shell-no-conteiner-docker-em-execucao

$ docker exec -i -t marcomob_web_1 /bin/bash






docker run --name meu-site -d -p 80:5000 -v "/home/rodrigo/minha_pasta:/var/www"



# MY_SQL
https://hub.docker.com/_/mysql
https://docs.docker.com/config/daemon/systemd/
