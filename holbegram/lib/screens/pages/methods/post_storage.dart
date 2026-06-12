import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holbegram/models/post.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import 'package:uuid/uuid.dart';

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> uploadPost(
    String caption,
    String uid,
    String username,
    String profImage,
    Uint8List image,
  ) async {
    try {
      final postId = const Uuid().v1();
      final uploadResult = await _storageMethods.uploadImageToCloudinary(
        true,
        'posts',
        image,
      );
      final postUrl = uploadResult['secure_url'] ?? '';

      final post = Post(
        caption: caption,
        uid: uid,
        username: username,
        likes: <dynamic>[],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        profImage: profImage,
      );

      await _firestore.collection('posts').doc(postId).set(post.toJson());
      return 'Ok';
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> deletePost(String postId, String publicId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }
}