import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text(
            '나의 티켓',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: const Icon(Icons.confirmation_number_outlined),
          backgroundColor: Color(0xFF2525E7),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person_outline, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100, 
              child: CarouselScreen(),
            ),
            TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicatorWeight: 3,
            tabs: [
              Tab(text: '공연'),
              Tab(text: '특강'),
            ],
          ),
            Expanded(
              child: TabBarView(
                children: [
                  PerformanceTab(),
                  LectureTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          filters: ['전체', '음악', '퍼포먼스', '연극/뮤지컬'],
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
          filters: ['전체', '전공', '신앙', '기타'],
          selectedFilter: selectedFilter,
          onFilterSelected: (filter) {
            setState(() {
              selectedFilter = filter;
            });
          },
        ),
        Expanded(child: CardList(type: 'Lecture', itemCount: 8)),
      ],
    );
  }
}

class FilterChips extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const FilterChips({
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Wrap(
        spacing: 8.0,
        children: filters.map((filter) {
          final isSelected = filter == selectedFilter;
          return GestureDetector(
            onTap: () => onFilterSelected(filter),
            child: Chip(
              label: Text(filter),
              backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final String type;
  final int itemCount;

  const CardList({required this.type, required this.itemCount, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const Center(
                    child: Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$type Card $index',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Text(
                  'Subtitle here',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
              color: Colors.red,
              child: const Center(
                  child: Text('Page 1',
                      style: TextStyle(color: Colors.white, fontSize: 24)))),
          Container(
              color: Colors.orange,
              child: const Center(
                  child: Text('Page 2',
                      style: TextStyle(color: Colors.white, fontSize: 24)))),
          Container(
              color: Colors.yellow,
              child: const Center(
                  child: Text('Page 3',
                      style: TextStyle(color: Colors.black, fontSize: 24)))),
          Container(
              color: Colors.blue,
              child: const Center(
                  child: Text('Page 4',
                      style: TextStyle(color: Colors.white, fontSize: 24)))),
        ],
      ),
    );
  }
}