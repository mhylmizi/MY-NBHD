import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AnnouncementSortOption {
  Newest,
  Oldest,
  Alphabetical,
}

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage>
    with SingleTickerProviderStateMixin {
  AnnouncementSortOption _sortOption = AnnouncementSortOption.Newest;
  final bool _showPastEvents = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                  'Announcements',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: 'Upcoming Events'),
                Tab(text: 'Past Events'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAnnouncementsList(upcoming: true),
                  _buildAnnouncementsList(upcoming: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementsList({required bool upcoming}) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('announcements')
          .orderBy(
            'date',
            descending: _sortOption == AnnouncementSortOption.Newest,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final announcements = snapshot.data?.docs ?? [];

        // Filter announcements based on upcoming and past events
        final currentDate = DateTime.now();
        final filteredAnnouncements = announcements.where((announcement) {
          final date = (announcement['date'] as Timestamp?)?.toDate();
          if (upcoming) {
            return date != null && date.isAfter(currentDate);
          } else {
            return date != null && date.isBefore(currentDate);
          }
        }).toList();

        // Sort filtered announcements based on selected sort option
        switch (_sortOption) {
          case AnnouncementSortOption.Newest:
          case AnnouncementSortOption.Oldest:
            // Already sorted by date
            break;
          case AnnouncementSortOption.Alphabetical:
            filteredAnnouncements.sort((a, b) {
              final titleA = a['title'] as String? ?? '';
              final titleB = b['title'] as String? ?? '';
              return titleA.compareTo(titleB);
            });
            break;
        }

        return Column(
          children: [
            DropdownButton<AnnouncementSortOption>(
              value: _sortOption,
              onChanged: (AnnouncementSortOption? newValue) {
                setState(() {
                  _sortOption = newValue ?? AnnouncementSortOption.Newest;
                });
              },
              items: AnnouncementSortOption.values
                  .map<DropdownMenuItem<AnnouncementSortOption>>(
                (AnnouncementSortOption value) {
                  return DropdownMenuItem<AnnouncementSortOption>(
                    value: value,
                    child: Text(
                      value == AnnouncementSortOption.Newest
                          ? 'Sort by Newest'
                          : value == AnnouncementSortOption.Oldest
                              ? 'Sort by Oldest'
                              : 'Sort Alphabetically',
                    ),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAnnouncements.length,
                itemBuilder: (context, index) {
                  final announcement = filteredAnnouncements[index].data()
                      as Map<String, dynamic>?;

                  if (announcement == null) {
                    return Container(); // Placeholder widget if the announcement is null
                  }

                  final title = announcement['title'] as String? ?? '';
                  final date = (announcement['date'] as Timestamp?)
                          ?.toDate()
                          .toString() ??
                      '';
                  final info = announcement['info'] as String? ?? '';
                  final time = announcement['time'] as String? ?? '';

                  return Card(
                    child: ListTile(
                      title: Text(title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: $date'),
                          Text('Info: $info'),
                          Text('Time: $time'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AnnouncementsPage(),
  ));
}
