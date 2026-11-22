# Etapa 7 - Gerenciamento de Estado Global e Recursos do Dispositivo

## Mecanismo de Gerenciamento de Estado Utilizado
Foi utilizado o pacote **`provider`** em conjunto com a classe nativa **`ChangeNotifier`** do Flutter, seguindo o padrão arquitetural MVVM/Reativo.

## Identificação dos Estados Tratados Globalmente
* **Lista de Ingressos Adquiridos (`_ingressos`):** Coleção de ingressos salvos pelo usuário.
* **Contador Total de Ingressos (`totalIngressos`):** Propriedade derivada reativa exibida na barra superior da aplicação.
* **Estado de Carregamento (`_carregando`):** Controle assíncrono durante operações de leitura e gravação.

## Justificativa para o Tratamento como Estado Global
Anteriormente, o estado dos ingressos estava isolado dentro da `TicketsScreen`. Quando o usuário finalizava uma compra na `CheckoutScreen`, outras telas do aplicativo (como a `HomeScreen`) não tinham visibilidade imediata dessa alteração. Ao elevar o estado para um `TicketProvider` no topo da árvore de widgets (`main.dart`), qualquer mutação (compra ou cancelamento) notifica automaticamente todas as telas inscritas (`notifyListeners()`), mantendo a contagem de ingressos na `AppBar` da tela inicial e a lista na aba "Meus Ingressos" perfeitamente sincronizadas em tempo real.

## Recurso Nativo Utilizado
Foi integrado o módulo de **Geolocalização (GPS / Fused Location)** através dos pacotes **`geolocator`** e **`geocoding`**.

## Justificativa da Escolha do Recurso
Em um aplicativo de venda de ingressos de cinema, identificar automaticamente a cidade do usuário permite contextualizar a exibição do catálogo ("Em Cartaz na sua região") sem exigir que o usuário digite manualmente sua localização, melhorando a experiência de uso (UX).

## Permissões Necessárias
* **Android (`AndroidManifest.xml`):**
  * `android.permission.ACCESS_FINE_LOCATION` (Localização precisa via GPS/Wi-Fi).
  * `android.permission.ACCESS_COARSE_LOCATION` (Localização aproximada via rede).
* **iOS (`Info.plist`):**
  * `NSLocationWhenInUseUsageDescription` (Justificativa exibida no pop-up nativo ao solicitar acesso em tempo de execução).

## Descrição do Fluxo de Utilização do Recurso
1. Ao abrir a `HomeScreen`, o método `_buscarLocalizacao()` aciona o `LocationService`.
2. O serviço verifica se o sensor de localização do aparelho está ativo.
3. Em seguida, verifica o status da permissão em tempo de execução (*Runtime Permission*). Caso ainda não tenha sido concedida, dispara o diálogo nativo do sistema operacional.
4. Com a permissão aprovada, captura as coordenadas geográficas (`Position`) utilizando precisão baixa (`LocationAccuracy.low`) para otimizar o consumo de bateria.
5. Utiliza geocodificação reversa (`placemarkFromCoordinates`) para traduzir latitude e longitude no nome do município, exibindo-o abaixo do título na `AppBar`.

## Tratamento de Falhas ou Indisponibilidade do Recurso
O `LocationService` implementa degradação graciosa para impedir falhas na interface:
* **GPS Desativado:** Retorna a mensagem informativa `"GPS desativado"` na barra superior sem travar a tela.
* **Permissão Negada / Bloqueada:** Captura os estados `LocationPermission.denied` e `deniedForever`, exibindo `"Permissão negada"` ou `"Localização bloqueada nos ajustes"`.
* **Indisponibilidade de Hardware / Ambiente Web:** Envolve toda a operação em um bloco `try/catch` que, em caso de exceção (como execução em navegadores sem suporte à API de Geocoding), define uma cidade padrão de contingência (`"Goiânia (Padrão)"`), mantendo o aplicativo 100% funcional.

## Instruções para Execução e Teste
1. Instale as dependências com `flutter pub get`.
2. Execute o projeto em um dispositivo físico, emulador ou Chrome (`flutter run -d chrome`).
3. Aceite a solicitação de localização exibida pelo navegador ou sistema operacional para visualizar a cidade detectada na barra superior.
4. Realize a compra de um ingresso e observe o contador no canto superior direito da tela inicial incrementar automaticamente de `0` para `1` sem necessidade de recarregar a página.