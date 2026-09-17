# Relatório da Etapa 3 - Navegação, UX e Acessibilidade

## 1. Descrição da estrutura de navegação implementada
A aplicação agora utiliza uma navegação baseada em abas inferiores (`BottomNavigationBar`), centralizada no arquivo `main_screen.dart`. Essa estrutura permite alternar rapidamente entre os contextos principais do aplicativo sem perder o estado das telas, proporcionando uma transição fluida entre as rotas.

## 2. Identificação das telas e respectivos mecanismos de acesso
- **Main Screen (Base):** Ponto de entrada que gerencia as abas.
- **Home (Em Cartaz):** Acessada através da primeira aba inferior (ícone de rolo de filme). Exibe a lista de filmes. A partir dela, o usuário navega para a tela de **Detalhes** através do clique no card do filme (navegação em pilha via `Navigator.push`).
- **Perfil:** Acessada através da segunda aba inferior (ícone de pessoa). Atualmente exibe um *placeholder* informando que estará disponível em breve.
- **Seleção de Assentos e Checkout:** Acessadas sequencialmente a partir da tela de Detalhes, utilizando navegação em pilha (`Navigator.push`), permitindo que o usuário retorne à tela anterior a qualquer momento usando a seta padrão na `AppBar`.

## 3. Descrição dos mecanismos de feedback visual implementados
- **SnackBar:** Na tela de Checkout, ao clicar em "Confirmar Compra", uma barra de notificação escura aparece na parte inferior da tela com a mensagem "Processando sua compra...", indicando que a ação foi registrada e está em andamento.
- **AlertDialog:** Após o tempo de processamento simulado (1 segundo), um pop-up modal confirma o sucesso da operação, travando interações em background até que o usuário clique em "Voltar ao Início".
- **Feedback de Seleção:** Na tela de assentos, a poltrona clicada muda imediatamente sua cor de azul para verde, fornecendo uma resposta visual instantânea da escolha.

## 4. Principais decisões de UX adotadas
- **Aplicação da Lei de Fitts:** Os botões de ação primária ("Avançar para o Pagamento" e "Confirmar Compra") foram posicionados na parte inferior da tela e tiveram sua altura aumentada (`minimumSize: Size(double.infinity, 54)`), facilitando drasticamente o alcance e o toque pelo polegar do usuário ao segurar o celular com uma mão.
- O mesmo princípio foi aplicado ao mapa de assentos (ajuste do `childAspectRatio`), garantindo que as poltronas tenham uma área clicável ergonômica.

## 5. Medidas de acessibilidade implementadas
- Foi adicionado o widget `Semantics` em elementos visuais não triviais, garantindo suporte a leitores de tela (como TalkBack/VoiceOver).
- O mapa de assentos agora lê "Assento A1" e informa seu estado ("Selecionado" ou "Disponível para seleção").
- O layout ilustrativo da sala informa "Ilustração da tela do cinema".
- As mudanças de seleção acionam a propriedade `liveRegion: true`, forçando o leitor de tela a anunciar imediatamente qual poltrona foi selecionada.

## 6. Instruções para execução e teste da navegação
1. No terminal, acesse a pasta `src/mobile/`.
2. Execute o comando `flutter run` (pode ser testado no navegador web via `flutter run -d chrome`).
3. Para testar acessibilidade, recomenda-se a execução em um dispositivo físico ou emulador com o TalkBack ativado nas configurações do sistema.