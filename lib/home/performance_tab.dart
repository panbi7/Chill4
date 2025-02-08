import 'package:flutter/material.dart';
import 'filter_chips.dart';
import 'card_list.dart';

class PerformanceTab extends StatefulWidget {
  const PerformanceTab({super.key});

  @override
  State<PerformanceTab> createState() => _PerformanceTabState();
}

class _PerformanceTabState extends State<PerformanceTab> {
  String selectedFilter = '전체';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterChips(
          filters: const ['전체', '음악', '퍼포먼스', '연극/뮤지컬'],
          selectedFilter: selectedFilter,
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
          },
        ),
        Expanded(child: CardList(type: 'Performance', itemCount: 10)),
      ],
    );
  }
}
