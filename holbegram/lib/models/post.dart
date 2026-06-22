import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    required this.caption,
    required this.uid,
    required this.username,
    required this.likes,
    required this.savedBy,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  final String caption;
  final String uid;
  final String username;
  final List<dynamic> likes;
  final List<dynamic> savedBy;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  static Post fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    final published = snapshot['datePublished'];

    return Post(
      caption: snapshot['caption'] ?? '',
      uid: snapshot['uid'] ?? '',
      username: snapshot['username'] ?? '',
      likes: List<dynamic>.from(snapshot['likes'] ?? []),       // ✅ corrigé
      savedBy: List<dynamic>.from(snapshot['savedBy'] ?? []),   // ✅ corrigé
      postId: snapshot['postId'] ?? snap.id,                    // ✅ fallback sécurisé
      datePublished: published is Timestamp
          ? published.toDate()
          : published as DateTime,
      postUrl: snapshot['postUrl'] ?? '',
      profImage: snapshot['profImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'uid': uid,
      'username': username,
      'likes': likes,
      'savedBy': savedBy,
      'postId': postId,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profImage': profImage,
    };
  }
}