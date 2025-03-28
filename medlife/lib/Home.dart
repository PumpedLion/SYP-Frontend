import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String username;
  final String profileImage;

  HomeScreen({required this.username, required this.profileImage});

  final List<Map<String, String>> meditationItems = [
    {
      "image": "assets/image4.png",
      "title": "Mindfulness",
      "description": "Relax and be in the moment",
    },
    {
      "image": "assets/image5.png",
      "title": "Stress Relief",
      "description": "Let go of worries and breathe",
    },
    {
      "image": "assets/image6.png",
      "title": "Deep Focus",
      "description": "Improve concentration and clarity",
    },
    {
      "image": "assets/image7.png",
      "title": "Sleep Better",
      "description": "Prepare your mind for restful sleep",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E1B2B),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20),
            _buildMeditationCard(),
            SizedBox(height: 20),
            _buildCategoryChips(),
            SizedBox(height: 20),
            _buildForYouSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(profileImage), // Passed Profile Image
              radius: 25,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello $username', // Passed Name
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "How's your Mood Today?",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        Icon(Icons.notifications, color: Colors.white),
      ],
    );
  }

  Widget _buildMeditationCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1E2A3A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "17 Days Of Meditations",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            "Build a positive habit of Meditating",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text("Start"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF66CCFF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip("All", selected: true),
          SizedBox(width: 8),
          _buildChip("Music"),
          SizedBox(width: 8),
          _buildChip("Meditation"),
          SizedBox(width: 8),
          _buildChip("Focus"),
          SizedBox(width: 8),
          _buildChip("Stress"),
        ],
      ),
    );
  }

  Widget _buildChip(String label, {bool selected = false}) {
    return Chip(
      label: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.white70)),
      backgroundColor: selected ? Color(0xFF66CCFF) : Color(0xFF1E2A3A),
    );
  }

  Widget _buildForYouSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "For You",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: meditationItems.length,
          itemBuilder: (context, index) {
            return _buildMeditationCardItem(
              meditationItems[index]["image"]!,
              meditationItems[index]["title"]!,
              meditationItems[index]["description"]!,
            );
          },
        ),
      ],
    );
  }

  Widget _buildMeditationCardItem(String image, String title, String description) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E2A3A),
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                description,
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
