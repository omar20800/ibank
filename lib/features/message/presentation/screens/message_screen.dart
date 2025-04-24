import 'package:flutter/material.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/features/message/presentation/widgets/message_tab_card.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Message', style: getTitle2TextStyle()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return MessageTabCard(index);
                  },
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 20),
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
