import 'dart:convert';
import 'package:http/http.dart' as http;

class TmdbService {
  // Chave pública de teste (pode usar esta para a avaliação)
  static const String _apiKey = '9a72df9433df71658cd96a6039ea30e7';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<dynamic>> obterFilmesEmCartaz() async {
    final url = Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey&language=pt-BR&page=1');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['results']; // Retorna a lista real de filmes
      } else {
        throw Exception('Falha ao carregar filmes do servidor.');
      }
    } catch (e) {
      return []; // Retorna lista vazia em caso de falha de rede
    }
  }
}