# CineFácil

Aplicativo mobile para compra de ingressos de cinema de forma prática e rápida.

## Sobre o projeto
O CineFácil permite que usuários consultem filmes em cartaz, visualizem horários, escolham assentos e comprem ingressos e combos diretamente pelo celular, eliminando filas e trazendo comodidade.

## Problema resolvido
Filas nas bilheterias, incerteza sobre disponibilidade de assentos e falta de integração na compra de ingressos e combos.

## Público-alvo
Frequentadores de cinema que buscam agilidade e praticidade.

## Tecnologias utilizadas
- **Mobile:** Flutter
- **Backend:** Node.js + Express (em desenvolvimento nas próximas etapas)
- **Banco de dados:** PostgreSQL / MongoDB (em definição)
- **API externa:** The Movie Database (TMDB)
- **Autenticação:** JWT

## Funcionalidades implementadas (Etapa 2)
- **Tela Inicial (Home):** Listagem de filmes em cartaz com dados dinâmicos simulados (*mocks*).
- **Tela de Detalhes:** Exibição de sinopse, gênero, duração e classificação do filme selecionado.
- **Seleção de Assentos:** Mapa interativo em grade (GridView) permitindo a escolha manual da poltrona.
- **Checkout e Confirmação:** Resumo detalhado da compra e diálogo modal de conclusão de pedido com geração de ingresso digital.

## Telas previstas
- Home com filmes em cartaz
- Detalhes do filme
- Seleção de assentos
- Checkout e pagamento
- Confirmação com ingresso digital
- Perfil e histórico

## Como executar o projeto

### Mobile (Flutter)
cd src/mobile
flutter pub get
flutter run

### Backend (Node.js)
cd src/backend
npm install
npm run dev

### Estrutura do projeto
CineFacil/
├── README.md
├── docs/
│   ├── proposta.md
│   └── etapa-02.md
├── src/
│   ├── mobile/
│   └── backend/
└── tests/

## Status do projeto
Em desenvolvimento - Etapa 02 (Protótipo de Interface) concluída

## Disciplina
Projeto da disciplina Tecnologia de construção de software 2 - PUC GO
