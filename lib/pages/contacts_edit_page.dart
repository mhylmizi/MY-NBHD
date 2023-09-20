import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsEditPage extends StatefulWidget {
  const ContactsEditPage({Key? key}) : super(key: key);

  @override
  _ContactsEditPageState createState() => _ContactsEditPageState();
}

class _ContactsEditPageState extends State<ContactsEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Save the form data to Firestore
      FirebaseFirestore.instance.collection('emergencyContacts').add({
        'name': _nameController.text,
        'phoneNum': _phoneNumController.text,
      }).then((_) {
        // Clear the form after successfully submitting
        _formKey.currentState!.reset();
      }).catchError((error) {
        // Handle any errors that occur during form submission
        print('Error: $error');
        // Show an error dialog or display a snackbar
      });
    }
  }

  void _deleteContact(String contactId) {
    FirebaseFirestore.instance
        .collection('emergencyContacts')
        .doc(contactId)
        .delete()
        .then((_) {
      // Handle successful deletion
    }).catchError((error) {
      // Handle any errors that occur during deletion
      print('Error: $error');
      // Show an error dialog or display a snackbar
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Emergency Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green, // Set the text color to white
                    ),
                    child: const Text('Add Contact'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Emergency Contacts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('emergencyContacts')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final emergencyContacts = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: emergencyContacts.length,
                      itemBuilder: (context, index) {
                        final contact = emergencyContacts[index];
                        final contactId = contact.id;
                        final contactData =
                            contact.data() as Map<String, dynamic>;
                        final name = contactData['name'];
                        final phoneNum = contactData['phoneNum'];

                        return ListTile(
                          title: Text(name),
                          subtitle: Text('Phone Number: $phoneNum'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteContact(contactId),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
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
