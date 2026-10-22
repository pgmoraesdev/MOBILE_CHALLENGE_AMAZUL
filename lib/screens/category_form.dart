import 'package:flutter/material.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
} 

class _CategoryFormState extends State<CategoryForm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar um novo tema'),
      ),  
      body: Center(
        child: const Text(''),
        )
      );
  }
}