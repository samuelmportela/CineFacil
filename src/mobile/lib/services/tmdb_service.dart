import 'package:dio/dio.dart';

class TmdbService {
  static const String _apiKey = '9a72df9433df71658cd96a6039ea30e7'; 
  
  // Configuração global da instância do Dio (Aula 16)
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: const Duration(seconds: 10), // Timeout nativo do Dio
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
      },
    ),
  )..interceptors.addAll([
      // 1. A mágica do Interceptor: Injeta a API Key em TODAS as rotas automaticamente
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['api_key'] = _apiKey;
          options.queryParameters['language'] = 'pt-BR';
          return handler.next(options); // Continua a viagem da requisição
        },
      ),
      // 2. Interceptor de Log: Imprime no terminal o tráfego da rede para o professor ver
      LogInterceptor(
        requestHeader: false,
        responseBody: false, 
        request: true,
      ),
    ]);

  // Operação de consulta de dados (GET)
  static Future<List<dynamic>> obterFilmesEmCartaz() async {
    try {
      // Como o Interceptor já coloca a API Key, o código da requisição fica super limpo!
      final response = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': 1},
      );
      
      // Dio parseia JSON automaticamente
      return response.data['results'];
      
    } on DioException catch (e) {
      // Captura erros automáticos de status 4xx e 5xx da Aula 15
      print('Erro HTTP Status: ${e.response?.statusCode}');
      throw Exception('Falha ao carregar filmes do servidor.');
    } catch (e) {
      throw Exception('Erro de conexão ou timeout.');
    }
  }
}