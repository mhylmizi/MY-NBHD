import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_nbhd_test/pages/announcements_edit_page.dart';
import 'package:my_nbhd_test/pages/contacts_edit_page.dart';
import 'package:my_nbhd_test/pages/suggestions_page.dart';
import 'package:my_nbhd_test/pages/view_complaints_page.dart';
import 'users_page.dart';

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Admin Dashboard'),
        actions: const [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          OptionCard(
            title: 'Users',
            icon: Icons.people,
            onTap: () {
              // Navigate to the users page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsersPage()),
              );
            },
          ),
          OptionCard(
            title: 'Announcements',
            icon: Icons.announcement,
            onTap: () {
              // Navigate to the products page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AnnouncementsEditPage()),
              );
            },
          ),
          OptionCard(
            title: 'Contacts',
            icon: Icons.contact_emergency,
            onTap: () {
              // Navigate to the products page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactsEditPage()),
              );
            },
          ),
          OptionCard(
            title: 'Suggestions',
            icon: Icons.newspaper,
            onTap: () {
              // Navigate to the products page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewSuggestionsPage()),
              );
            },
          ),
          OptionCard(
            title: 'Complaints',
            icon: Icons.notification_important,
            onTap: () {
              // Navigate to the products page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewComplaintsPage()),
              );
            },
          ),
          // Add more OptionCard widgets for additional pages
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const OptionCard({super.key, 
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
