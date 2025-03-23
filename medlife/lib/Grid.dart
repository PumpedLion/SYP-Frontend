import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: GridPage());
  }
}

class GridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

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
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 80, // Increase avatar size
                    backgroundColor:
                        Colors.transparent, // Prevents color overlay issues
                    foregroundImage: AssetImage(
                      'assets/Icons/Aman.png',
                    ), // Ensures full image is displayed
                  ),

                  title: Text(
                    'Hi John,',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Refresh the mind and spirit\nAnd bring clarity and focus',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildProgressItem('Yoga Session', 'assets/yoga.png', 0.6),
                  buildProgressItem('Peaceful', 'assets/peaceful.png', 0.8),
                  buildProgressItem('Nature', 'assets/nature.png', 0.4),
                  buildProgressItem('Awaken', 'assets/awaken.png', 0.9),
                  buildProgressItem('Calm', 'assets/calm.png', 0.2),
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
      color: Colors.grey[900],
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
