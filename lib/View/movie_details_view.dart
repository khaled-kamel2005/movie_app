// import 'package:flutter/material.dart';
// import '../service/api_service.dart';

// class MovieDetailsView extends StatelessWidget {
//   final int movieId;
//   const MovieDetailsView({super.key, required this.movieId});

//   @override
//   Widget build(BuildContext context) {
//     final ApiService apiService = ApiService();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Movie Details'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: apiService.getMovieDetails(movieId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return const Center(child: Text('Error loading details'));
//           }

//           final movie = snapshot.data!;
//           final posterPath = movie['poster_path'];
//           final imageUrl = posterPath != null
//               ? 'https://image.tmdb.org/t/p/w500$posterPath'
//               : 'https://via.placeholder.com/500';

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.network(
//                   imageUrl,
//                   width: double.infinity,
//                   height: 350,
//                   fit: BoxFit.cover,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         movie['title'] ?? '',
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           const Icon(Icons.star, color: Colors.amber),
//                           const SizedBox(width: 4),
//                           Text('${movie['vote_average']} / 10'),
//                           const SizedBox(width: 16),
//                           Text('Release Date: ${movie['release_date']}'),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         'Overview',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         movie['overview'] ?? 'No overview available.',
//                         style: const TextStyle(fontSize: 15, height: 1.4),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../service/api_service.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;
  const MovieDetailsView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiService.getMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading details'));
          }

          final movie = snapshot.data!;
          final posterPath = movie['poster_path'];
          final imageUrl = posterPath != null
              ? 'https://image.tmdb.org/t/p/w500$posterPath'
              : 'https://via.placeholder.com/500';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // برواز الصورة
                    Container(
                      width: 130,
                      height: 195,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepPurple, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie['title'] ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                '${movie['vote_average']} / 10',
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Release Date:\n${movie['release_date'] ?? 'N/A'}',
                            style: TextStyle(color: Colors.grey[700], height: 1.3),),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie['overview'] ?? 'No overview available.',
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}