import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MarkPage extends StatefulWidget {
  const MarkPage({super.key});

  @override
  State<MarkPage> createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marks')),
      body: const Center(child: Text('Mark Page')),
    );
  }
}
