import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementsEditPage extends StatefulWidget {
  const AnnouncementsEditPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsEditPageState createState() => _AnnouncementsEditPageState();
}

class _AnnouncementsEditPageState extends State<AnnouncementsEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _infoController.dispose();
    _timeController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        // Show an error message if the date is not selected
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Date Error'),
            content: const Text('Please select a date'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
        return;
      }

      // Save the form data to Firestore
      FirebaseFirestore.instance.collection('announcements').add({
        'date': Timestamp.fromDate(_selectedDate!),
        'info': _infoController.text,
        'time': _timeController.text,
        'title': _titleController.text,
      }).then((_) {
        // Clear the form after successfully submitting
        _formKey.currentState!.reset();
        setState(() {
          _selectedDate = null;
        });
      }).catchError((error) {
        // Handle any errors that occur during form submission
        print('Error: $error');
        // Show an error dialog or display a snackbar
      });
    }
  }

  void _deleteAnnouncement(String announcementId) {
    FirebaseFirestore.instance
        .collection('announcements')
        .doc(announcementId)
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
        title: const Text('Announcements'),
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
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: TextEditingController(
                          text: _selectedDate != null
                              ? _selectedDate!.toString().split(' ')[0]
                              : '',
                        ),
                        decoration: const InputDecoration(labelText: 'Date'),
                        validator: (value) {
                          if (_selectedDate == null) {
                            return 'Please select a date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(labelText: 'Time'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a time';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _infoController,
                    decoration: const InputDecoration(labelText: 'Info'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter info';
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
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Announcements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('announcements')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final announcements = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: announcements.length,
                      itemBuilder: (context, index) {
                        final announcement = announcements[index];
                        final announcementId = announcement.id;
                        final announcementData =
                            announcement.data() as Map<String, dynamic>;
                        final title = announcementData['title'];
                        final date = announcementData['date'].toDate();
                        final time = announcementData['time'];
                        final info = announcementData['info'];

                        return ListTile(
                          title: Text(title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date: $date'),
                              Text('Time: $time'),
                              Text('Info: $info'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                _deleteAnnouncement(announcementId),
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
