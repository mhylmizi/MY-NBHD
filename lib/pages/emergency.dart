import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum SortOption {
  NameAscending,
  NameDescending,
}

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  SortOption _selectedSortOption = SortOption.NameAscending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          '',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Add functionality to open notifications
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white12,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Emergency Contacts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<SortOption>(
                value: _selectedSortOption,
                onChanged: (SortOption? newValue) {
                  setState(() {
                    _selectedSortOption = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: SortOption.NameAscending,
                    child: Text('Name (A - Z)'),
                  ),
                  DropdownMenuItem(
                    value: SortOption.NameDescending,
                    child: Text('Name (Z - A)'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('emergencyContacts')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final contacts = snapshot.data?.docs ?? [];

                  contacts.sort((a, b) {
                    final contactA = a.data() as Map<String, dynamic>?;
                    final contactB = b.data() as Map<String, dynamic>?;
                    String valueA = '';
                    String valueB = '';

                    switch (_selectedSortOption) {
                      case SortOption.NameAscending:
                        valueA = contactA?['name'] as String? ?? '';
                        valueB = contactB?['name'] as String? ?? '';
                        break;
                      case SortOption.NameDescending:
                        valueA = contactB?['name'] as String? ?? '';
                        valueB = contactA?['name'] as String? ?? '';
                        break;
                    }

                    return valueA.compareTo(valueB);
                  });

                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact =
                          contacts[index].data() as Map<String, dynamic>?;

                      if (contact == null) {
                        return Container(); // Placeholder widget if the contact is null
                      }

                      final name = contact['name'] as String? ?? '';
                      final phoneNum = contact['phoneNum'] as String? ?? '';

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(name),
                            subtitle: Text(
                              phoneNum,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.phone),
                              onPressed: () {
                                _launchPhoneApp(phoneNum);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchPhoneApp(String phoneNum) {
    Fluttertoast.showToast(
      msg: 'Phone app would be launched with number: $phoneNum',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: EmergencyPage(),
  ));
}
