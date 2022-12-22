import 'dart:convert';

import 'package:flutter_http_networking/models/post.dart';
import 'package:http/http.dart' as http;

class PostClient {
  static const baseURL = "https://jsonplaceholder.typicode.com";
  static const postsEndpoint = "$baseURL/posts";

  /// Make this a singleton class
  PostClient._privateConstructor();
  static final PostClient instance = PostClient._privateConstructor();

  /// Fetching data
  Future<Post> fetchPost(http.Client client, int postId) async {
    final url = Uri.parse("$postsEndpoint/$postId");
    // final response = await http.get(url);
    final response = await client.get(url); // Testing

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post: $postId');
    }
  }

  /// Create post
  Future<Post> createPost(String title, String body) async {
    final url = Uri.parse(postsEndpoint);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'title': title,
          'body': body,
        },
      ),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  /// Update post
  Future<Post> updatePost(int postId, String title, String body) async {
    final url = Uri.parse('$postsEndpoint/$postId');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'title': title,
          'body': body,
        },
      ),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  /// Delete post
  Future<Post> deletePost(int postId) async {
    final url = Uri.parse('$postsEndpoint/$postId');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete post: $postId');
    }
  }
}
