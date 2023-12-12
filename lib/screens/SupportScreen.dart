import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
     TextEditingController _textController = TextEditingController();
  List<String> messages = [];
  String defaultResponse =
      "How can we help you? Reach our customer care line on this number: +2348107541065, or send us a mail on:transportdriverscare@gmail.com";

  @override
  void initState() {
    super.initState();
    // Display default message when screen loads
    messages.add(defaultResponse);
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      setState(() {
        messages.add(text);
        // For now, every time a message is sent, display the default response
        messages.add(defaultResponse);
      });
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: const Text('Chat Support'),
        backgroundColor: const Color(0xFFf6fafd),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFf6fafd),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Align(
                      alignment: messages[index] == defaultResponse
                          ? Alignment.center
                          : Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 4.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: messages[index] == defaultResponse
                              ? Colors.grey[300]
                              : Colors.blue,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          messages[index],
                          style: TextStyle(
                            color: messages[index] == defaultResponse
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
          color: Color(0xFFf6fafd),
        ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
               height: 30.0,
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.grey), // Outline border
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration: const InputDecoration.collapsed(
                    // contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                    hintText: 'Send a message',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}