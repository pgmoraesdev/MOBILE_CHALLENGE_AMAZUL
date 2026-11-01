import 'package:flutter/material.dart';
import '../models/topic_model.dart';

class TopicListScreen extends StatefulWidget {
  const TopicListScreen({super.key});

  @override
  State<TopicListScreen> createState() => _TopicListScreenState();    
}

class _TopicListScreenState extends State<TopicListScreen> {
  final List<Topic> topics = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de temas"),
      ),
      body: Center(
        child: const Text('ABC'),
      )
    );
  }
}