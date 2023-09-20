import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintsForm extends StatefulWidget {
  const ComplaintsForm({Key? key}) : super(key: key);

  @override
  _ComplaintsFormState createState() => _ComplaintsFormState();
}

class _ComplaintsFormState extends State<ComplaintsForm> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSubmitting = false;
  final int minLetters = 10;

  Future<void> _submitComplaint() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not authenticated, handle accordingly
      return;
    }

    final message = _messageController.text.trim();
    final subject = _subjectController.text.trim();

    if (subject.isEmpty || message.isEmpty) {
      // Show an error message or handle empty fields
      _showSubmissionMessage('Please fill in both subject and complaint.');
      return;
    }

    if (subject.length < minLetters || message.length < minLetters) {
      // Show an error message for minimum length requirement
      _showSubmissionMessage(
          'Subject and complaint must be at least $minLetters letters long.');
      return;
    }

    try {
      setState(() {
        _isSubmitting = true;
      });

      final complaintsCollection =
          FirebaseFirestore.instance.collection('complaints');

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final userData = userDoc.data();

      if (userData == null) {
        // Handle if user data is not available
        return;
      }

      final userName = '${userData['firstName']} ${userData['lastName']}';

      await complaintsCollection.add({
        'message': message,
        'subject': subject,
        'time': Timestamp.now(),
        'userId': user.uid,
        'userName': userName,
      });

      setState(() {
        _isSubmitting = false;
      });

      // Reset the text fields after submitting
      _messageController.clear();
      _subjectController.clear();

      // Show a success message
      _showSubmissionMessage('Complaint submitted successfully');

      // Redirect back to HomePage
      Navigator.pop(context);
    } catch (error) {
      setState(() {
        _isSubmitting = false;
      });

      // Show an error message or handle the error
      _showSubmissionMessage('Error submitting complaint');
    }
  }

  void _showSubmissionMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Complaints Form'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter the subject:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your complaint:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: _isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitComplaint,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Submit Complaint'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
