import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/models/post.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/pages/methods/post_storage.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final PostStorage _postStorage = PostStorage();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<UserProvider>().refreshUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserProvider>().user;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error ${snapshot.error}',
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final post = Post.fromSnap(docs[index]);

            return Container(
              margin: const EdgeInsets.all(8),
              height: 540,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  /// HEADER
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              post.profImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(post.username),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          onPressed: () async {
                            await _postStorage.deletePost(post.postId, '');

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Post Deleted'),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  /// CAPTION + IMAGE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.caption),

                        const SizedBox(height: 10),

                        Container(
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(post.postUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// ICONS
                        Row(
                          children: [
                            /// FAVORIS (cœur)
                            IconButton(
                              onPressed: () async {
                                if (currentUser == null) return;

                                if (post.savedBy.contains(currentUser.uid)) {
                                  await FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(post.postId)
                                      .update({
                                    'savedBy': FieldValue.arrayRemove(
                                      [currentUser.uid],
                                    ),
                                  });
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(post.postId)
                                      .update({
                                    'savedBy': FieldValue.arrayUnion(
                                      [currentUser.uid],
                                    ),
                                  });
                                }
                              },
                              icon: Icon(
                                currentUser != null &&
                                        post.savedBy.contains(currentUser.uid)
                                    ? Icons.favorite        // ❤️ plein
                                    : Icons.favorite_border, // 🤍 vide
                                color: currentUser != null &&
                                        post.savedBy.contains(currentUser.uid)
                                    ? Colors.red
                                    : null,
                              ),
                            ),

                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.chat_bubble_outline),
                            ),

                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.comment_outlined),
                            ),

                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.bookmark_border),
                            ),

                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.send_outlined),
                            ),

                            const Spacer(),

                            if (currentUser != null)
                              Text(currentUser.username),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}