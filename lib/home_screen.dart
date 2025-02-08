import 'package:chill4_promotion_community/my_page.dart';
import 'package:flutter/material.dart';
import 'home/carousel_screen.dart';
import 'home/performance_tab.dart';
import 'home/lecture_tab.dart';

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
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.confirmation_number_outlined),
          backgroundColor: const Color(0xFF2525E7),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search_outlined, color: Colors.black),
              onPressed: () {
                
              },
            ),
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {},
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.person_outline, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyPage(),
                    ),
                  );
                  },
                );
              }
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
              tabs: const [
                Tab(text: '공연'),
                Tab(text: '특강'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: const [
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
