import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({super.key});

  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  String _address = '';
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    final docSnapshot = await userData.get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      setState(() {
        _address = data['address'] ?? '';
        _email = data['email'] ?? '';
        _firstName = data['firstName'] ?? '';
        _lastName = data['lastName'] ?? '';
        _phoneNumber = data['phoneNumber'] ?? '';
      });
    } else {
      print('User document does not exist');
    }
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('User Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDataRow('Address:', _address),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            _buildDataRow('Email:', _email),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            _buildDataRow('First Name:', _firstName),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            _buildDataRow('Last Name:', _lastName),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            _buildDataRow('Phone Number:', _phoneNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const Spacer(),
          Text(
            data,
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
