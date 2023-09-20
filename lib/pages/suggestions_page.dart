import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ViewSuggestionsPage extends StatelessWidget {
  const ViewSuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('View Suggestions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Suggestions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('suggestions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final suggestions = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        final suggestionData =
                            suggestion.data() as Map<String, dynamic>;
                        final message = suggestionData['message'];
                        final time = suggestionData['time'] as Timestamp;
                        final userId = suggestionData['userId'];
                        final subject =
                            suggestionData['subject'] ?? 'No Subject';

                        final formattedDate =
                            DateFormat('MMMM d, y').format(time.toDate());

                        return ListTile(
                          title: Text(subject),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('User ID: $userId'),
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
