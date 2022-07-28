## Descrição

lib para consumir API(Kobana) e criar uma cobrança pix através do endpoint 'charge/pix'

## Como usar

>Obs: Antes crie um aquivo .env e coloque as informações necessárias

```
API_BASE_URL=https://api-sandbox.kobana.com.br
API_VERSION=v2
API_TOKEN=seu token
```


Clone o repositório:

```
git clone git@github.com:Jannilsonn/pix.git
```

Entre no projeto:

```
cd pix
```

Faça o setup:

```
bin/setup
```

Abra o irb:

```
irb
```

carregue o arquivo:

```
equire_relative 'lib/pix'
```

Crie uma variável com os parâmetros:

```
params { amount: 100, pix_account_id: 1 , expire_at: "2023-12-02T10:03:56-03:00" }
```

Chame a classe Pix passando os parâmetros:

```
response = Pix.new(params: params).create
```

Pronto uma cobrança pix foi feita, agora as informações de response e request estão disponíveis para manipulação.
