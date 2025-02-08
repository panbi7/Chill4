import 'package:flutter/material.dart';
import 'filter_chips.dart';
import 'card_list.dart';

class LectureTab extends StatefulWidget {
  const LectureTab({super.key});

  @override
  State<LectureTab> createState() => _LectureTabState();
}

class _LectureTabState extends State<LectureTab> {
  String selectedFilter = '전체';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterChips(
          filters: const ['전체', '전공', '신앙', '기타'],
          selectedFilter: selectedFilter,
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
          },
        ),
        Expanded(child: CardList(type: 'Lecture', itemCount: 10)),
      ],
    );
  }
}
