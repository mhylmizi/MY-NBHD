import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_nbhd_test/pages/payment_details_page.dart';

class BillsPage extends StatelessWidget {
  final String collectionName = 'bills';

  const BillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not authenticated, handle accordingly
      return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: Text('User not authenticated.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.green,
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
                  'Bills',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(collectionName)
                  .where('fullName', isEqualTo: '${user.displayName}')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No bills available.'));
                }

                final bills = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: bills.length,
                  itemBuilder: (context, index) {
                    final bill = bills[index];
                    final data = bill.data() as Map<String, dynamic>;

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Type: ${data['type'] ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Month: ${data['month'] ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Deadline: ${data['deadline'] ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      // Add the button at the bottom
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to PaymentDetailsPage when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentDetailsPage()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.payment),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: BillsPage(),
  ));
}
