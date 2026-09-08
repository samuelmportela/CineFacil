# Relatório da Etapa 2 - Implementação do Protótipo de Interface

## 1. Identificação das telas implementadas
- **Tela Inicial (Home):** Exibe a listagem de filmes em cartaz utilizando dados simulados (*mocks*), contendo título, gênero, duração e classificação indicativa. Permite navegar para a tela de detalhes ao clicar em um filme.
- **Tela de Detalhes do Filme:** Apresenta informações complementares do filme selecionado, incluindo uma sinopse completa e um botão de ação para avançar para a escolha da sessão e assentos.
- **Tela de Seleção de Assentos:** Funciona como um mapa interativo da sala de cinema (grade de poltronas). Permite que o usuário interaja e selecione um assento específico (entrada de dados visual).
- **Tela de Checkout:** Mostra o resumo detalhado da compra (filme escolhido, poltrona selecionada e valor total) e um botão de confirmação que exibe um alerta de sucesso ao concluir.

## 2. Descrição dos principais componentes utilizados
- `Scaffold` e `AppBar`: Estrutura padrão de layout e barra superior com título e cores customizadas.
- `ListView.builder`: Utilizado para renderizar de forma eficiente a lista dinâmica de filmes em cartaz.
- `GridView.builder`: Empregado na criação do mapa interativo de assentos da sala de cinema.
- `GestureDetector`: Utilizado para capturar o toque do usuário nas poltronas individuais.
- `ElevatedButton`: Botões estilizados para transições de tela e ações principais.
- `AlertDialog`: Componente de diálogo modal exibido ao finalizar a compra.

## 3. Identificação dos componentes reutilizáveis
- Os dados dos filmes foram centralizados em uma camada de mock (`lib/mocks/movies_mock.dart`), permitindo que a listagem e os detalhes consumam a mesma estrutura de dados de forma padronizada.
- A estrutura de navegação (`Navigator.push`) foi encapsulada de forma limpa entre as telas localizadas em `lib/screens/`.

## 4. Descrição dos elementos de entrada de dados
- O principal elemento de entrada de dados interativo desta etapa é o **Mapa de Assentos (GridView)**, onde o usuário clica diretamente em uma poltrona (ex: 'A1', 'B2') para realizar a seleção, alterando o estado visual do componente através de `StatefulWidget`.

## 5. Estratégias utilizadas para adaptação a diferentes tamanhos de tela
- Utilização de `Expanded` e `GridView` com contagem flexível de colunas para garantir que o layout se adapte corretamente tanto em telas mobile compactas quanto em resoluções maiores (como tablets ou navegadores web).
- Uso de `SizedBox(width: double.infinity)` nos botões de ação para preencher uniformemente a largura disponível.

## 6. Instruções para execução da aplicação
1. Certifique-se de ter o Flutter instalado no ambiente.
2. Navegue até a pasta do projeto mobile (`src/mobile/`).
3. Execute o comando para rodar no navegador ou emulador:
   ```bash
   flutter run
