import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Users'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final List<User> users = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final String id = doc.id;
            final String firstName = data['firstName'] ?? '';
            final String lastName = data['lastName'] ?? '';
            final String email = data['email'] ?? '';
            final String phoneNum = data['phoneNum'] ?? '';
            final String address = data['address'] ?? '';

            return User(
              id: id,
              firstName: firstName,
              lastName: lastName,
              email: email,
              phoneNum: phoneNum,
              address: address,
            );
          }).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return UserCard(
                user: user,
                onDelete: () {
                  // Delete the user from Firestore
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.id)
                      .delete();
                },
              );
            },
          );
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onDelete;

  const UserCard({
    required this.user,
    required this.onDelete,
    Key? key, // Add the Key parameter here
  }) : super(key: key); // Pass the key to the super constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(user.id), // Use the user's ID as the key
      child: ListTile(
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            Text(user.phoneNum),
            Text(user.address),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNum;
  final String address;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNum,
    required this.address,
  });
}
