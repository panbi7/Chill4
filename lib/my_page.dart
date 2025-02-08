import 'package:chill4_promotion_community/event_manager/event_form.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이 페이지'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('김소다', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('chill4GuYs', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    child: const Text('프로필 편집'),
                  ),
                ],
              ),
            ),
            const Divider(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InterestScreen(),
                        ),
                      );
                    },
                    child: Column(
                      children: const [
                        Text('관심', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('0', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TicketHistoryScreen(),
                        ),
                      );
                    },
                    child: Column(
                      children: const [
                        Text('티켓내역', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('0', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HostedEventsScreen(),
                        ),
                      );
                    },
                    child: Column(
                      children: const [
                        Text('주최한 행사', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            ListTile(
              title: const Text('아이디'),
              subtitle: const Text('exampleID'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('비밀번호'),
              subtitle: const Text('********'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('이메일'),
              subtitle: const Text('example@email.com'),
              onTap: () {},
            ),
            const Divider(),

            ListTile(
              title: const Text('이용약관'),
              onTap: () {

              },
            ),
            ListTile(
              title: const Text('버전 정보'),
              subtitle: const Text('v1.0.0'),
              onTap: () {},
            ),
            const Divider(),

            ListTile(
              title: const Text('로그아웃'),
              onTap: () {

              },
            ),
            ListTile(
              title: const Text('회원탈퇴'),
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}

class InterestScreen extends StatelessWidget {
  const InterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('관심'),
      ),
      body: const Center(
        child: Text('관심 화면입니다.'),
      ),
    );
  }
}

class TicketHistoryScreen extends StatelessWidget {
  const TicketHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('티켓내역'),
      ),
      body: const Center(
        child: Text('티켓내역 화면입니다.'),
      ),
    );
  }
}