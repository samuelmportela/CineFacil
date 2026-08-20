# Proposta do Projeto - CineFácil

## 1. Nome da aplicação
**CineFácil**

## 2. Problema que a aplicação pretende resolver
Atualmente, comprar ingressos para o cinema ainda envolve filas nas bilheterias, incerteza sobre a disponibilidade de assentos e falta de informação consolidada sobre horários e combos. O CineFácil resolve esses problemas ao permitir que o usuário:
- Consulte a programação completa em tempo real;
- Escolha seus assentos preferidos com antecedência;
- Compre ingressos e combos de forma rápida e integrada;
- Tenha acesso digital ao ingresso, evitando filas e papel.

## 3. Público-alvo
- Jovens e adultos frequentadores de cinemas;
- Famílias que planejam saídas culturais;
- Pessoas que buscam praticidade e agilidade na compra de ingressos;
- Usuários de smartphones que preferem serviços digitais.

## 4. Objetivo principal
Desenvolver uma aplicação mobile que permita ao usuário consultar filmes em cartaz, visualizar horários de sessões, selecionar assentos disponíveis e comprar ingressos com ou sem combos, de forma intuitiva e eficiente.

## 5. Principais funcionalidades
| # | Funcionalidade |
|---|----------------|
| 1 | Listar filmes em cartaz com cartazes e notas |
| 2 | Visualizar detalhes do filme (sinopse, elenco, duração, trailer) |
| 3 | Filtrar filmes por gênero e data |
| 4 | Visualizar horários das sessões por dia |
| 5 | Selecionar assentos disponíveis no mapa da sala |
| 6 | Adicionar combos de pipoca e bebida ao pedido |
| 7 | Finalizar compra com resumo do pedido |
| 8 | Gerar ingresso digital com QR Code |
| 9 | Histórico de compras do usuário |
| 10 | Login e cadastro de usuários |

## 6. Telas previstas (mínimo 4)
| Tela | Descrição |
|------|-----------|
| **Home** | Lista de filmes em cartaz com carrossel e destaques |
| **Detalhes do Filme** | Sinopse, elenco, avaliação, trailer e horários disponíveis |
| **Seleção de Assentos** | Mapa interativo da sala com assentos livres/ocupados |
| **Checkout** | Resumo da compra (ingresso + combo), forma de pagamento e finalização |
| **Confirmação** | Ingresso digital com QR Code e dados da sessão |
| **Perfil** | Dados do usuário e histórico de compras |

## 7. Fluxo básico de navegação
Home → Detalhes do Filme → Seleção de Horário → Mapa de Assentos → Checkout → Confirmação
↓
Menu → Perfil → Histórico de Compras


## 8. Tecnologia escolhida para o desenvolvimento mobile
**Flutter**
- Justificativa: Framework moderno da Google que permite desenvolvimento multiplataforma (iOS e Android) com alta performance e rica biblioteca de widgets. Possui excelente suporte a animações e interfaces fluidas, o que é importante para a experiência do usuário em um app de cinema. Além disso, a comunidade é ativa e a documentação é completa.

## 9. Tecnologia escolhida para o backend
**Node.js + Express**
- Justificativa: Plataforma leve e assíncrona, ideal para aplicações com múltiplas requisições simultâneas. O ecossistema NPM oferece diversas bibliotecas para integração com bancos de dados e APIs externas. A curva de aprendizado é acessível e permite desenvolvimento rápido.

**Banco de Dados:** PostgreSQL ou MongoDB (a definir conforme modelo de dados final)

## 10. Necessidade de comunicação com APIs externas
Sim. Será utilizada a **API do The Movie Database (TMDB)** para:
- Buscar filmes em cartaz;
- Obter sinopses, elenco, duração, cartazes e trailers;
- Manter os dados de filmes sempre atualizados sem a necessidade de alimentação manual.

## 11. Forma prevista de armazenamento de dados
- **TMDB:** Dados públicos dos filmes (consumidos via API);
- **Banco próprio (Node.js + PostgreSQL/MongoDB):** Dados de usuários, compras, assentos reservados e histórico;
- **Sessões e assentos:** Controlados pelo backend próprio para garantir consistência nas reservas.

## 12. Repositório Git
O projeto será mantido em repositório público no GitHub com a estrutura descrita abaixo.

## 13. Estrutura inicial de diretórios do projeto
CineFacil/
├── README.md
├── .gitignore
├── docs/
│ └── proposta.md
├── src/
│ ├── mobile/ # Aplicação Flutter
│ └── backend/ # Node.js + Express
└── tests/
├── mobile/
└── backend/


## Decisões técnicas iniciais
| Decisão | Escolha | Justificativa |
|---------|---------|---------------|
| Framework mobile | Flutter | Multiplataforma, performance, UI rica |
| Backend | Node.js + Express | Leve, assíncrono, ecossistema vasto |
| API externa | TMDB | Dados completos e atualizados de filmes |
| Banco de dados | PostgreSQL/MongoDB | A definir conforme necessidades de relacionamento |
| Autenticação | JWT | Stateless, seguro e fácil de implementar |
