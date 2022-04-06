import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Map<String, dynamic> data;
  Details({required this.data});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data['login'],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  data['avatar_url'],
                ),
                radius: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.entries.map((entry) {
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${entry.key}:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${entry.value}",
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
