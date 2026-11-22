import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/tmdb_service.dart';
import '../services/location_service.dart';
import '../providers/ticket_provider.dart';
import '../components/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _filmesFuturos;
  String _cidadeAtual = 'Buscando localização...';

  @override
  void initState() {
    super.initState();
    // Inicia a requisição à API do TMDB ao abrir a tela
    _filmesFuturos = TmdbService.obterFilmesEmCartaz();
    // Busca a localização do dispositivo via GPS
    _buscarLocalizacao();
  }

  Future<void> _buscarLocalizacao() async {
    final cidade = await LocationService.obterCidadeAtual();
    if (mounted) {
      setState(() => _cidadeAtual = cidade);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CineFácil - Em Cartaz',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  _cidadeAtual,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        actions: [
          // Escuta o Estado Global para exibir o contador de ingressos em tempo real
          Consumer<TicketProvider>(
            builder: (context, provider, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Chip(
                  avatar: const Icon(
                    Icons.confirmation_number,
                    size: 16,
                    color: Colors.blue,
                  ),
                  label: Text('${provider.totalIngressos}'),
                  backgroundColor: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
      // O FutureBuilder gerencia a conexão e os estados da requisição
      body: FutureBuilder<List<dynamic>>(
        future: _filmesFuturos,
        builder: (context, snapshot) {
          // 1. Feedback visual de carregamento
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // 2. Tratamento de erro
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar filmes. Verifique sua conexão.'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhum filme em cartaz no momento.'),
            );
          }

          final filmesTmdb = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: filmesTmdb.length,
            itemBuilder: (context, index) {
              final tmdbMovie = filmesTmdb[index];
              
              final movieAdaptado = {
                'title': tmdbMovie['title'] ?? 'Sem Título',
                'genre': 'Nota TMDB: ${tmdbMovie['vote_average']}', 
                'duration': 'Lançamento: ${tmdbMovie['release_date']}',
                'rating': tmdbMovie['adult'] == true ? '18' : 'Livre',
                'poster': tmdbMovie['poster_path'],
                'sinopse': tmdbMovie['overview'],
              };

              return MovieCard(movie: movieAdaptado);
            },
          );
        },
      ),
    );
  }
}