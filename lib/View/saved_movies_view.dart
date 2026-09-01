import 'package:flutter/material.dart';

class SavedMoviesView extends StatelessWidget {
  final String title;
  final List<dynamic> movies;

  const SavedMoviesView({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: movies.isEmpty
          ? const Center(child: Text('No movies added yet'))
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                final posterPath = movie['poster_path'];
                final imageUrl = posterPath != null
                    ? 'https://image.tmdb.org/t/p/w500$posterPath'
                    : 'https://via.placeholder.com/500';

                return ListTile(
                  leading: Image.network(
                    imageUrl,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie['title'] ?? ''),
                  subtitle: Text('Rating: ${movie['vote_average']}'),
                );
              },
            ),
    );
  }
}