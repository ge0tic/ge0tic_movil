import 'package:flutter/material.dart';

class MarkdownWidget extends StatelessWidget {
  final String data;

  MarkdownWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: buildMarkdown(),
      ),
    );
  }

  Widget buildMarkdown() => MarkdownWidget(data: data);
}
