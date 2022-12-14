import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_http_networking/utils/post_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostClient _postClient = PostClient.instance;
  final http.Client _client = http.Client();

  String? _postTitle;
  String? _postBody;
  String? _requestType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter http'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _requestType != null
                ? Center(
                    child: Text(
                      _requestType!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: 16),
            _postTitle != null ? Text('Title:\n$_postTitle') : Container(),
            const SizedBox(height: 8),
            _postBody != null ? Text('Body:\n$_postBody') : Container(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final post = await _postClient.fetchPost(_client, 1);
                    setState(() {
                      _requestType = 'GET';
                      _postTitle = post.title;
                      _postBody = post.body;
                    });
                  },
                  child: const Text('GET'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final post = await _postClient.createPost(
                      'Hi Dart',
                      'Dart hello world',
                    );
                    setState(() {
                      _requestType = 'POST';
                      _postTitle = post.title;
                      _postBody = post.body;
                    });
                  },
                  child: const Text('POST'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final post = await _postClient.updatePost(
                      1,
                      "Hello Flutter",
                      "Flutter hello world",
                    );
                    setState(() {
                      _requestType = 'PUT';
                      _postTitle = post.title;
                      _postBody = post.body;
                    });
                  },
                  child: const Text('UPDATE'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final post = await _postClient.deletePost(2);
                    setState(() {
                      _requestType = 'DELETE';
                      _postTitle = post.title;
                      _postBody = post.body;
                    });
                  },
                  child: const Text('DELETE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
