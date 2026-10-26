import 'package:flutter/material.dart';
import '../services/tmdb_service.dart';
import '../components/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _filmesFuturos;

  @override
  void initState() {
    super.initState();
    // Inicia a requisição à API do TMDB ao abrir a tela
    _filmesFuturos = TmdbService.obterFilmesEmCartaz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineFácil - Em Cartaz', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      // O FutureBuilder gerencia a conexão e os estados da requisição
      body: FutureBuilder<List<dynamic>>(
        future: _filmesFuturos,
        builder: (context, snapshot) {
          // 1. Feedback visual de carregamento (Exigência Etapa 05)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // 2. Tratamento de erro (Exigência Etapa 05)
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar filmes. Verifique sua conexão.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum filme em cartaz no momento.'));
          }

          final filmesTmdb = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: filmesTmdb.length,
            itemBuilder: (context, index) {
              final tmdbMovie = filmesTmdb[index];
              
              // Mapeia os dados da API para o formato que a sua tela de Detalhes já aceita,
              // evitando que ela "quebre" por falta de variáveis.
              final movieAdaptado = {
                'title': tmdbMovie['title'] ?? 'Sem Título',
                'genre': 'Nota TMDB: ${tmdbMovie['vote_average']}', 
                'duration': 'Lançamento: ${tmdbMovie['release_date']}',
                'rating': tmdbMovie['adult'] == true ? '18' : 'Livre',
                'poster': tmdbMovie['poster_path'],
                'sinopse': tmdbMovie['overview'],
              };

              // Chama o componente modularizado!
              return MovieCard(movie: movieAdaptado);
            },
          );
        },
      ),
    );
  }
}