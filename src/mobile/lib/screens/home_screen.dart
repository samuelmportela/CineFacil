import 'package:flutter/material.dart';
import '../mocks/movies_mock.dart';
import 'movie_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineFácil - Em Cartaz', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockMovies.length,
        itemBuilder: (context, index) {
          final movie = mockMovies[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 70,
                color: Colors.blue[100],
                child: Icon(Icons.movie, color: Colors.blue[900]),
              ),
              title: Text(movie['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${movie['genre']} • ${movie['duration']}\nClassificação: ${movie['rating']} anos'),
              isThreeLine: true,
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navega para a tela de detalhes enviando o filme selecionado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(movie: movie),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
