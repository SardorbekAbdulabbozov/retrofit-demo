import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_demo/retrofit/api_client.dart';
import 'model/data.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  _ScreenOneState createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Retrofit Demo in Flutter',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  FutureBuilder<ResponseData> _buildBody(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
      future: client.getUsers(),
      builder: (context, AsyncSnapshot<ResponseData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final ResponseData posts = snapshot.data!;
          return _buildListView(context, posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }
      },
    );
  }

  // build list view & its tile
  Widget _buildListView(BuildContext context, ResponseData posts) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(
              Icons.account_box,
              color: Colors.green,
              size: 50,
            ),
            title: Text(
              posts.data[index]['name'],
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(posts.data[index]['email']),
          ),
        );
      },
      itemCount: posts.data.length,
    );
  }
}
