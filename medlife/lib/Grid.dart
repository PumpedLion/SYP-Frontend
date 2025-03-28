import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,  );
  }
}

class GridPage extends StatelessWidget {
  final String username;
  final String profileImage;

  // Constructor to accept name and profile image from the previous page
  GridPage({required this.username, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1A2F),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                height: 150,
                child: Row(
                  children: [
                    SizedBox(
                      width: 80, // Adjust width
                      height: 80, // Adjust height
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(profileImage), // Use the passed profile image
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      // Ensures the Column doesn't overflow
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hi $username,', // Use the passed name
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Refresh the mind and spirit And bring clarity and focus',
                            style: TextStyle(color: Colors.white70),
                            maxLines:
                                2, // Prevents text from growing infinitely
                            overflow:
                                TextOverflow
                                    .ellipsis, // Adds '...' if text overflows
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildProgressItem('Yoga Session', 'assets/image10.png', 0.6),
                  buildProgressItem('Peaceful', 'assets/image11.png', 0.8),
                  buildProgressItem('Nature', 'assets/image12.png', 0.4),
                  buildProgressItem('Awaken', 'assets/image5.png', 0.9),
                  buildProgressItem('Calm', 'assets/image6.png', 0.2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressItem(String title, String image, double progress) {
    return Card(
      color: Color(0xFF041222),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
        ),
        title: Text(title, style: TextStyle(color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'In Progress ${(progress * 100).toInt()}%',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 5),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
            ),
          ],
        ),
      ),
    );
  }
}
