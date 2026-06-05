import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    required this.caption,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.publicId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  final String caption;
  final String uid;
  final String username;
  final List<dynamic> likes;
  final String postId;
  final String publicId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  static Post fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    final published = snapshot['datePublished'];

    return Post(
      caption: snapshot['caption'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      likes: snapshot['likes'],
      postId: snapshot['postId'],
        publicId: snapshot['publicId'] ?? snapshot['postId'],
      datePublished:
          published is Timestamp ? published.toDate() : published as DateTime,
      postUrl: snapshot['postUrl'],
      profImage: snapshot['profImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'uid': uid,
      'username': username,
      'likes': likes,
      'postId': postId,
      'publicId': publicId,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profImage': profImage,
    };
  }
}