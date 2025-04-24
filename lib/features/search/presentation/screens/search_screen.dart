import 'package:flutter/material.dart';
import 'package:ibank/core/utils/text_style.dart';
import 'package:ibank/features/search/presentation/widgets/search_list_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search', style: getTitle2TextStyle()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SearchListCard(index);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
