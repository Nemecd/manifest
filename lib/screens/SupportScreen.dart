import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFf6fafd),
      ),
      child: const Center(
        child: Text(
          'This is the Support Screen',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
   );
  }
}