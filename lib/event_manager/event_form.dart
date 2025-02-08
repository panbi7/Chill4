import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Event Registration',
      home: const EventRegistrationForm(),
    );
  }
}

class EventRegistrationForm extends StatefulWidget {
  const EventRegistrationForm({super.key});

  @override
  _EventRegistrationFormState createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  // Radio button for event type: only one can be selected.
  // Possible values: 'performance' or 'lecture'
  String? eventType;

  // Dropdown selections
  String? selectedCategory;
  String? selectedLocation;
  String? selectedSeating;
  int totalSessions = 1;

  // TextField controllers for host, duration, price, and title
  final TextEditingController hostController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  // Controllers for session fields (date, time, total attendees)
  List<TextEditingController> dateControllers = [];
  List<TextEditingController> timeControllers = [];
  List<TextEditingController> attendeeControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeSessionControllers();
  }

  // Initialize controllers for sessions
  void _initializeSessionControllers() {
    dateControllers =
        List.generate(totalSessions, (_) => TextEditingController());
    timeControllers =
        List.generate(totalSessions, (_) => TextEditingController());
    attendeeControllers =
        List.generate(totalSessions, (_) => TextEditingController());
  }

  // Update session controllers when totalSessions changes
  void _updateSessionControllers(int newTotal) {
    if (newTotal > dateControllers.length) {
      for (int i = dateControllers.length; i < newTotal; i++) {
        dateControllers.add(TextEditingController());
        timeControllers.add(TextEditingController());
        attendeeControllers.add(TextEditingController());
      }
    } else if (newTotal < dateControllers.length) {
      for (int i = dateControllers.length - 1; i >= newTotal; i--) {
        dateControllers[i].dispose();
        timeControllers[i].dispose();
        attendeeControllers[i].dispose();
        dateControllers.removeAt(i);
        timeControllers.removeAt(i);
        attendeeControllers.removeAt(i);
      }
    }
    setState(() {
      totalSessions = newTotal;
    });
  }

  // Save form data to Firestore
  Future<void> _saveFormData() async {
    final String? selectedEventType = eventType; // 'performance' or 'lecture'
    final String host = hostController.text;
    final String duration = durationController.text;
    final String price = priceController.text;
    final String title = titleController.text;
    final String? category = selectedCategory;
    final String? location = selectedLocation;
    final String? seating = selectedSeating;

    // Collect session data into a list
    List<Map<String, dynamic>> sessions = [];
    for (int i = 0; i < totalSessions; i++) {
      sessions.add({
        'session': i + 1,
        'date': dateControllers[i].text,
        'time': timeControllers[i].text,
        'attendees': attendeeControllers[i].text, // 필요시 int 변환 가능
      });
    }

    final data = {
      'eventType': selectedEventType,
      'host': host,
      'duration': duration,
      'price': price,
      'title': title,
      'category': category,
      'location': location,
      'seating': seating,
      'sessions': sessions,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('events').add(data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  void dispose() {
    hostController.dispose();
    durationController.dispose();
    priceController.dispose();
    titleController.dispose();
    for (var controller in dateControllers) {
      controller.dispose();
    }
    for (var controller in timeControllers) {
      controller.dispose();
    }
    for (var controller in attendeeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Registration'),
        actions: [
          IconButton(
            onPressed: _saveFormData,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Event Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<String>(
                  value: 'performance',
                  groupValue: eventType,
                  onChanged: (value) {
                    setState(() {
                      eventType = value;
                    });
                  },
                ),
                const Text('Performance'),
                const SizedBox(width: 16),
                Radio<String>(
                  value: 'lecture',
                  groupValue: eventType,
                  onChanged: (value) {
                    setState(() {
                      eventType = value;
                    });
                  },
                ),
                const Text('Lecture'),
              ],
            ),
            const SizedBox(height: 16),
            // Host input field
            TextField(
              controller: hostController,
              decoration: const InputDecoration(
                labelText: 'Host',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'none', child: Text('None')),
                DropdownMenuItem(value: 'category1', child: Text('Category 1')),
                DropdownMenuItem(value: 'category2', child: Text('Category 2')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'none', child: Text('None')),
                DropdownMenuItem(value: 'location1', child: Text('Location 1')),
                DropdownMenuItem(value: 'location2', child: Text('Location 2')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Seating',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'none', child: Text('None')),
                DropdownMenuItem(value: 'seating1', child: Text('Seating 1')),
                DropdownMenuItem(value: 'seating2', child: Text('Seating 2')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedSeating = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Duration input field
            TextField(
              controller: durationController,
              decoration: const InputDecoration(
                labelText: 'Duration',
                prefixIcon: Icon(Icons.access_time),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Price input field
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                suffixText: 'USD',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Title and description input field
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Enter Title',
                hintText: 'Enter Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const Text('Poster',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              onPressed: () {
                // Poster upload functionality (e.g., integrate image_picker)
              },
              icon: const Icon(Icons.add),
              label: const Text('Upload'),
            ),
            const SizedBox(height: 16),
            // Total sessions selection
            Row(
              children: [
                const Text('Total Sessions:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: totalSessions,
                  items: List.generate(
                    10,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      _updateSessionControllers(value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // DataTable for session details: date, time, total attendees
            DataTable(
              columns: const [
                DataColumn(label: Text('Session')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Attendees')),
              ],
              rows: List.generate(
                totalSessions,
                (index) => DataRow(
                  cells: [
                    DataCell(Text('${index + 1}')),
                    DataCell(
                      TextField(
                        controller: dateControllers[index],
                        decoration:
                            const InputDecoration(hintText: 'YYYY/MM/DD'),
                      ),
                    ),
                    DataCell(
                      TextField(
                        controller: timeControllers[index],
                        decoration: const InputDecoration(hintText: 'HH:MM'),
                      ),
                    ),
                    DataCell(
                      TextField(
                        controller: attendeeControllers[index],
                        decoration: const InputDecoration(
                            hintText: 'Total Attendees'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Button to save the form data to Firestore
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveFormData,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}