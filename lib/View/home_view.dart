// import 'package:flutter/material.dart';
// import '../Service/api_service.dart';
// import 'movie_details_view.dart';
// import 'saved_movies_view.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final ApiService _apiService = ApiService();
//   List<dynamic> _movies = [];
//   bool _isLoading = true;
//   final TextEditingController _searchController = TextEditingController();

//   static final List<dynamic> favoriteMovies = [];
//   static final List<dynamic> watchlistMovies = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMovies();
//   }

//   void _loadMovies() async {
//     try {
//       final movies = await _apiService.getPopularMovies();
//       setState(() {
//         _movies = movies;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _onSearch(String query) async {
//     setState(() => _isLoading = true);
//     final results = await _apiService.searchMovies(query);
//     setState(() {
//       _movies = results;
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Movies App'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Colors.deepPurple),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(color: Colors.white, fontSize: 24),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.favorite, color: Colors.red),
//               title: const Text('Favorites'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SavedMoviesView(
//                       title: 'Favorites',
//                       movies: favoriteMovies,
//                     ),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.bookmark, color: Colors.blue),
//               title: const Text('Watchlist'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SavedMoviesView(
//                       title: 'Watchlist',
//                       movies: watchlistMovies,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: TextField(
//               controller: _searchController,
//               onChanged: _onSearch,
//               decoration: InputDecoration(
//                 hintText: 'Search movies...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : GridView.builder(
//                     padding: const EdgeInsets.all(8),
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.6,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     itemCount: _movies.length,
//                     itemBuilder: (context, index) {
//                       final movie = _movies[index];
//                       final posterPath = movie['poster_path'];
//                       final imageUrl = posterPath != null
//                           ? 'https://image.tmdb.org/t/p/w500$posterPath'
//                           : 'https://via.placeholder.com/500';

//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MovieDetailsView(
//                                 movieId: movie['id'],
//                               ),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 4,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: ClipRRect(
//                                   borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(12),
//                                   ),
//                                   child: Image.network(
//                                     imageUrl,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   movie['title'] ?? 'No Title',
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.favorite_border,
//                                         color: Colors.red),
//                                     onPressed: () {
//                                       favoriteMovies.add(movie);
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                           content: Text('Added to Favorites'),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.bookmark_border,
//                                         color: Colors.blue),
//                                     onPressed: () {
//                                       watchlistMovies.add(movie);
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                           content: Text('Added to Watchlist'),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Service/api_service.dart';
import '../providers/movies_provider.dart';
import '../providers/auth_provider.dart';
import 'movie_details_view.dart';
import 'saved_movies_view.dart';
import 'login_view.dart';
import 'package:firebase_auth/firebase_auth.dart'hide AuthProvider;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ApiService _apiService = ApiService();
  List<dynamic> _movies = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() async {
    try {
      final movies = await _apiService.getPopularMovies();
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _onSearch(String query) async {
    setState(() => _isLoading = true);
    final results = await _apiService.searchMovies(query);
    setState(() {
      _movies = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepPurple),
              accountName: const Text('Welcome User',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail:  Text(
                currentUser?.email ?? 'No User',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text('Favorites'),
              trailing: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red.shade100,
                child: Text(
                  '${moviesProvider.favoriteMovies.length}',
                  style: const TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavedMoviesView(
                      title: 'Favorites',
                      movies: moviesProvider.favoriteMovies,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark, color: Colors.blue),
              title: const Text('Watchlist'),
              trailing: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  '${moviesProvider.watchlistMovies.length}',
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavedMoviesView(
                      title: 'Watchlist',
                      movies: moviesProvider.watchlistMovies,
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.grey),
              title: const Text('Logout'),
              onTap: () async {
                await authProvider.logout();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _movies.length,
                    itemBuilder: (context, index) {
                      final movie = _movies[index];
                      final posterPath = movie['poster_path'];
                      final imageUrl = posterPath != null
                          ? 'https://image.tmdb.org/t/p/w500$posterPath'
                          : 'https://via.placeholder.com/500';

                      final isFav = moviesProvider.isFavorite(movie['id']);
                      final isWatch = moviesProvider.isInWatchlist(movie['id']);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsView(
                                movieId: movie['id'],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  movie['title'] ?? 'No Title',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      moviesProvider.toggleFavorite(movie);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isWatch
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      moviesProvider.toggleWatchlist(movie);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
