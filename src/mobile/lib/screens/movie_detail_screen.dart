import 'package:flutter/material.dart';
import 'seat_selection_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      // SingleChildScrollView permite rolar a tela se o texto da sinopse for muito grande
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. A IMAGEM DO PÔSTER VINDO DA INTERNET EM ALTA RESOLUÇÃO
            if (movie['poster'] != null)
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie['poster']}',
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              )
            else
              Container(
                width: double.infinity,
                height: 400,
                color: Colors.blue[100],
                child: Icon(Icons.movie, size: 100, color: Colors.blue[900]),
              ),
            
            // 2. OS DETALHES DO FILME E SINOPSE
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['title'],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${movie['genre']} • ${movie['duration']} • Classificação: ${movie['rating']}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sinopse',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie['sinopse'] ?? 'Sinopse não disponível.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  
                  // 3. BOTÃO PARA COMPRAR INGRESSO
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navega para a seleção de assentos enviando o título
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeatSelectionScreen(movieTitle: movie['title']),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Selecionar Assentos', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}