# Etapa 6 - Integração com API Externa

## Identificação da API Utilizada
A aplicação consome a **TMDB API (The Movie Database)**, um serviço RESTful externo que fornece catálogos de filmes, séries e metadados de cinema atualizados.

## Endereço e Base URL
* **Base URL:** `https://api.themoviedb.org/3`

## Descrição dos Endpoints e Método HTTP
* **Endpoint Utilizado:** `/movie/now_playing`
* **Método HTTP:** `GET` (Exclusivo para recuperação/leitura de dados, sem envio de Body).
* **Parâmetros de Query:** `api_key` (Autenticação), `language` (pt-BR) e `page` (1).

## Estrutura dos Dados Trocados (JSON)
O formato universal utilizado na comunicação é o JSON. 
A requisição não envia Body (payload). A resposta (Response) devolve um objeto JSON que contém um Array de Objetos na chave `"results"`.
Cada filme é estruturado com chaves e valores, incluindo:
* `id` (Numérico)
* `title` (String)
* `overview` (String, sinopse)
* `poster_path` (String, URI da imagem)
* `vote_average` (Numérico, avaliação)

## Descrição do Fluxo de Comunicação
1. A `HomeScreen` inicia e despacha a requisição HTTP de forma assíncrona (via pacote `Dio`).
2. A requisição vai para a Network Thread no background para não travar a UI Thread (Main Thread) do Flutter a 60fps.
3. O pacote Dio processa a conversão de String JSON para estrutura Map/List do Dart de forma automática.
4. O `FutureBuilder` escuta a resposta e aciona o redesenho da tela (`render`) com a lista de filmes.

## Tratamento dos Estados da Requisição
A gerência de estados foi implementada nativamente via `FutureBuilder`:
* **Carregamento (Loading):** Durante a latência (ConnectionState.waiting), é exibido um `CircularProgressIndicator` central.
* **Sucesso (2xx):** Ao receber Status Code 200 OK, a lista de filmes é renderizada através de um `ListView.builder`.
* **Erro (4xx e 5xx):** Capturados via `DioException`. Se o servidor estiver inoperante (Status 5xx) ou houver falha de rota (Status 4xx), o App exibe a mensagem de fallback *"Erro ao carregar filmes. Verifique sua conexão."*, impedindo que a aplicação congele.
* **Ausência de Dados:** Caso a resposta venha com `statusCode == 200` mas a lista de resultados esteja vazia (`hasData` falso ou `isEmpty`), é renderizada a mensagem de aviso: *"Nenhum filme em cartaz no momento."*.

## Configuração do Serviço e Teste
1. A API do TMDB exige uma chave de autenticação (Bearer Token ou API Key). 
2. A chave de desenvolvedor deve ser injetada como parâmetro de query (para fins avaliativos, a variável `_apiKey` contém uma credencial de leitura restrita, que não viola dados sensíveis de escrita).
3. Para testar: Rode `flutter run -d chrome`. Desconecte a internet para visualizar o estado de erro, ou aguarde o tempo de carregamento natural para validar o sucesso e a exibição das capas puxadas da web.