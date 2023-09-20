import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ViewComplaintsPage extends StatelessWidget {
  const ViewComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('View Complaints'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Complaints',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('complaints')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final complaints = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        final complaint = complaints[index];
                        final complaintData =
                            complaint.data() as Map<String, dynamic>;
                        final subject = complaintData['subject'];
                        final message = complaintData['message'];
                        final time = complaintData['time'] as Timestamp;
                        final userName = complaintData['userName'];

                        final formattedDate =
                            DateFormat('MMMM d, y').format(time.toDate());

                        return ListTile(
                          title: Text(subject),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('User Name: $userName'),
                              Text('Message: $message'),
                              Text('Date: $formattedDate'),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
