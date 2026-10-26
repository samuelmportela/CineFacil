# Etapa 5 - Primeira Versão Funcional com Backend

## Descrição do Fluxo Completo de Negócio
O fluxo implementado permite a jornada completa de compra de um ingresso de cinema consumindo dados reais. O usuário abre o aplicativo e visualiza os filmes reais em cartaz (buscados via API do TMDB). Ele seleciona um filme, é direcionado aos detalhes e, em seguida, à seleção responsiva de assentos. Na tela de checkout, caso não escolha um assento, é impedido de avançar. Ao selecionar corretamente e confirmar, a compra é simulada, o ingresso é persistido localmente no dispositivo e o usuário pode conferir o QR Code gerado na aba "Meus Ingressos".

## Passo a Passo para Executar o Fluxo
1. Inicie a aplicação na rota inicial (`HomeScreen`).
2. Aguarde o indicador de carregamento buscar a lista de filmes na API do TMDB.
3. Clique sobre o card de um dos filmes apresentados (agora componentizado e com imagem da web).
4. Na tela de detalhes, clique para selecionar o assento.
5. Na grade de assentos, avance direto para o pagamento SEM selecionar um assento (para testar o bloqueio/validação).
6. Volte, selecione uma poltrona (ela ficará verde) e vá para o pagamento.
7. Confirme a compra.
8. Navegue até a aba "Ingressos" no menu inferior para ver o ingresso salvo com o QR Code.

## Funcionalidades Integradas Nesta Etapa
* Integração de Frontend com Backend (consumo da API REST do TMDB).
* Persistência de dados locais da Etapa 4 (`shared_preferences`).
* Navegação em Pilha (Stack) e em Abas (BottomNavigationBar).
* Componentização de UI (criação do `MovieCard` isolado).
* Grade responsiva de assentos (`SliverGridDelegateWithMaxCrossAxisExtent`).

## Tratamento de Entradas Inválidas
Foi implementada uma trava de segurança na `CheckoutScreen`. Se a variável `seat` estiver vazia ou com o valor padrão "Nenhum assento selecionado", o botão "Confirmar Compra" aborta a execução imediatamente (usando `return`) antes de salvar qualquer dado.

## Mecanismos de Feedback Utilizados
* **CircularProgressIndicator:** Exibido no `FutureBuilder` enquanto os filmes estão sendo baixados da API.
* **SnackBar de Erro (Vermelho):** Exibido quando o usuário tenta comprar sem selecionar poltrona.
* **SnackBar de Sucesso:** Informa que a requisição de pagamento está sendo processada.
* **AlertDialog:** Pop-up central confirmando a geração do ingresso digital.

## Principais Decisões Técnicas
* **API do TMDB:** Escolhida para fornecer dados reais, eliminando a dependência de arquivos *mockados* e elevando o nível do protótipo.
* **FutureBuilder:** Utilizado para gerenciar os estados da requisição assíncrona (carregando, erro e sucesso) de forma declarativa e integrada à UI do Flutter.
* **Componentização:** O card de filme foi extraído da tela principal para a pasta `components/movie_card.dart`, melhorando a reutilização do código, conforme feedback recebido nas etapas anteriores.

## Instruções para Execução e Teste
Recomenda-se a execução utilizando o renderizador web para testes rápidos ou em emulador/dispositivo físico:
`flutter run -d chrome --web-renderer html`
*(Nota: É necessário estar conectado à internet para que os dados da API sejam carregados).*