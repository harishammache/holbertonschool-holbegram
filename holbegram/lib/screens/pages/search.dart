import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (
          context,
          child,
          loadingProgress,
        ) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return const Center(
            child: Icon(
              Icons.broken_image,
              size: 40,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchText =
                        value.trim().toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon:
                      const Icon(Icons.search),
                  filled: true,
                  fillColor:
                      Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                    borderSide:
                        BorderSide.none,
                  ),
                ),
              ),
            ),

            /// POSTS
            Expanded(
              child:
                  StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore
                    .instance
                    .collection('posts')
                    .snapshots(),
                builder:
                    (context, snapshot) {
                  if (snapshot
                          .connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child:
                          CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erreur : ${snapshot.error}',
                      ),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot
                          .data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'Aucun post trouvé',
                      ),
                    );
                  }

                  final allPosts =
                      snapshot.data!.docs;

                  final filteredPosts =
                      allPosts.where((doc) {
                    final data =
                        doc.data()
                            as Map<String,
                                dynamic>;

                    final caption =
                        (data['caption'] ??
                                '')
                            .toString()
                            .toLowerCase();

                    return caption.contains(
                        _searchText);
                  }).toList();

                  if (filteredPosts.isEmpty) {
                    return const Center(
                      child: Text(
                        'Aucun résultat trouvé',
                      ),
                    );
                  }

                  return GridView.builder(
                    padding:
                        const EdgeInsets.all(4),
                    itemCount:
                        filteredPosts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing:
                          2,
                      mainAxisSpacing: 2,
                      childAspectRatio:
                          1,
                    ),
                    itemBuilder:
                        (context, index) {
                      final data =
                          filteredPosts[index]
                                  .data()
                              as Map<String,
                                  dynamic>;

                      return GestureDetector(
                        onTap: () {
                          // Navigation vers le détail du post
                        },
                        child: _buildImage(
                          data['postUrl'],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}