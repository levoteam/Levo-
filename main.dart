import 'package:flutter/material.dart';

void main() {
  runApp(const LevoApp());
}

class LevoApp extends StatelessWidget {
  const LevoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Levo App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF000000),
        primaryColor: const Color(0xFF00E5FF),
      ),
      home: const LevoLoginScreen(),
    );
  }
}

// 1. LOGIN SCREEN (Exact matching your video)
class LevoLoginScreen extends StatefulWidget {
  const LevoLoginScreen({super.key});

  @override
  State<LevoLoginScreen> createState() => _LevoLoginScreenState();
}

class _LevoLoginScreenState extends State<LevoLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.4), width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'LEVO LOGIN',
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username or Phone',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E5FF))),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: _isPasswordObscured,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00E5FF))),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF00E5FF),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00E5FF),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    onPressed: () {
                      if (_usernameController.text.isNotEmpty) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LevoDashboard(username: _usernameController.text),
                          ),
                        );
                      }
                    },
                    child: const Text('CONTINUE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 2. MAIN DASHBOARD (With Stories & Live Feature)
class LevoDashboard extends StatefulWidget {
  final String username;
  const LevoDashboard({super.key, required this.username});

  @override
  State<LevoDashboard> createState() => _LevoDashboardState();
}

class _LevoDashboardState extends State<LevoDashboard> {
  // Demo Data for User Stories
  final List<Map<String, String>> _stories = [
    {'user': 'My Story', 'isMe': 'true'},
    {'user': 'alex_99', 'isMe': 'false'},
    {'user': 'sam_rock', 'isMe': 'false'},
    {'user': 'johndoe', 'isMe': 'false'},
  ];

  void _addNewStory() {
    setState(() {
      _stories.insert(1, {'user': 'levo_user_${_stories.length}', 'isMe': 'false'});
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Story Uploaded Successfully! 🚀')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LEVO PANEL', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LevoLoginScreen()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Engine Sync Labels from your video
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("⚡ Search Engine & Location Engine Sync Active.", style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                  Text("📡 Tracked Device IP: Offline/Local Simulation", style: TextStyle(color: Colors.white60, fontSize: 11)),
                ],
              ),
            ),

            const Divider(color: Colors.white24),

            // DYNAMIC STORY SECTION
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child: Text("Stories", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF))),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _stories.length,
                itemBuilder: (context, index) {
                  final story = _stories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: story['isMe'] == 'true' ? Colors.grey : const Color(0xFF00E5FF),
                                  width: 2.5,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[900],
                                child: Icon(
                                  story['isMe'] == 'true' ? Icons.person : Icons.account_circle,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                            if (story['isMe'] == 'true')
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: _addNewStory,
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Color(0xFF00E5FF),
                                    child: Icon(Icons.add, size: 16, color: Colors.black),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(story['user']!, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Divider(color: Colors.white24),

            // LIVE STREAM ACTION BOARD
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[950],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Broadcast Live", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                        SizedBox(height: 4),
                        Text("Go live stream to your public room", style: TextStyle(fontSize: 12, color: Colors.white60)),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LevoLiveScreen(username: widget.username)),
                        );
                      },
                      icon: const Icon(Icons.videocam),
                      label: const Text("GO LIVE"),
                    ),
                  ],
                ),
              ),
            ),

            // FEEDS / PANEL PLACEHOLDERS (From your video)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Text("✦ Reel, Photo Post & Live Stream Panel Placeholder", style: TextStyle(color: Colors.white70, fontSize: 13)),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  height: 200,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_circle_outline, size: 50, color: const Color(0xFF00E5FF).withOpacity(0.5)),
                        const SizedBox(height: 8),
                        Text("Levo Stream/Reel Content Slot #${index + 1}", style: const TextStyle(color: Colors.white38)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 3. LIVE STREAMING SCREEN INTERFACE
class LevoLiveScreen extends StatelessWidget {
  final String username;
  const LevoLiveScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Simulated Camera Feedback (Black background placeholder)
          Container(
            color: Colors.grey[900],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.blur_on, size: 80, color: Colors.white24),
                  SizedBox(height: 10),
                  Text("Camera Stream Engine Initialized...", style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ),
          // Top Overlay Details
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                    children: [
                      Icon(Icons.fiber_manual_record, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text("LIVE", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                  child: Text("Host: $username", style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          // Bottom Controller (End Stream)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("STOP BROADCAST", style: TextStyle(fontWeight: FontWeight.bold)),
              )
