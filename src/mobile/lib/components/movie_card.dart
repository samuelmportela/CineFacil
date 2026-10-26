import 'package:flutter/material.dart';
import '../screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 70,
          // Agora ele busca a capa real do filme na internet!
          child: movie['poster'] != null
              ? Image.network('https://image.tmdb.org/t/p/w92${movie['poster']}', fit: BoxFit.cover)
              : Container(color: Colors.blue[100], child: Icon(Icons.movie, color: Colors.blue[900])),
        ),
        title: Text(movie['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${movie['genre']}\n${movie['duration']}\nClassificação: ${movie['rating']}'),
        isThreeLine: true,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(movie: movie),
            ),
          );
        },
      ),
    );
  }
}