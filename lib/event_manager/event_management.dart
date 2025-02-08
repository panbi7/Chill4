import 'package:chill4_promotion_community/event_manager/event_form.dart';
import 'package:flutter/material.dart';

class HostedEventsScreen extends StatefulWidget {
  const HostedEventsScreen({super.key});

  @override
  _HostedEventsScreenState createState() => _HostedEventsScreenState();
}

class _HostedEventsScreenState extends State<HostedEventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주최한 행사'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '공연'),
            Tab(text: '특강'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEventList('공연'),
          _buildEventList('특강'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventRegistrationForm(),
            ),
          );
        },
        label: const Text('글쓰기'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildEventList(String category) {
    final events = [
      {
        'title': '24-2 족쇄두 정기공연',
        'duration': '1시간 30분',
        'location': '학관 104호',
        'sessions': '총 3회',
        'price': '5,000원',
        'date': '2024.11.10-2024.11.11',
        'likes': '10',
        'image': 'assets/longplay.png',
      }
    ];

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  event['image'] ?? '',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          event['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.more_vert),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('${event['duration']} | ${event['location']}'),
                    Text('${event['sessions']}'),
                    Text('${event['price']}'),
                    Text('${event['date']}'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.favorite_border,
                            size: 20, color: Colors.grey),
                        Text(' ${event['likes']}'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
