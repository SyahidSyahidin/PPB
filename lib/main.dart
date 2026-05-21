import 'package:flutter/material.dart';

void main() {
  runApp(const ComicApp());
}

class ComicApp extends StatelessWidget {
  const ComicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ComicKu App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.greenAccent,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ComicHomeScreen(),
    const Center(child: Text('Halaman Favorit (Coming Soon)')),
    const Center(child: Text('Pengaturan Profil (Coming Soon)')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class ComicHomeScreen extends StatelessWidget {
  const ComicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> popularComics = [
      {
        'title': 'Frieren', 
        'genre': 'Fantasy', 
        'rating': '4.9', 
        'image': 'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx154587-g1roUE2rsJDL.jpg'
      },
      {
        'title': 'Tensura', 
        'genre': 'Isekai', 
        'rating': '4.8', 
        'image': 'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx101280-ezBM2S7MDb0D.jpg'
      },
      {
        'title': 'Tokyo Ghoul', 
        'genre': 'Dark Fantasy', 
        'rating': '4.7', 
        'image': 'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/nx20605-fmnHwdOQxEaq.jpg'
      },
      {
        'title': 'Nanatsu no Taizai', 
        'genre': 'Action', 
        'rating': '4.6', 
        'image': 'https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx20789-0H7EebZ8L1uM.jpg'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ComicKu', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage('https://s4.anilist.co/file/anilistcdn/media/anime/banner/154587-ivXNJ23SM1xB.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REKOMENDASI MINGGU INI', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12)),
                        SizedBox(height: 4),
                        Text('Frieren: Beyond Journey\'s End', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trending Sekarang 🔥', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Lihat Semua', style: TextStyle(color: Colors.greenAccent, fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularComics.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final comic = popularComics[index];
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(comic['image']!, fit: BoxFit.cover, width: 120),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(comic['title']!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(comic['genre']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text('Update Terbaru 🕒', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: popularComics.length,
                itemBuilder: (context, index) {
                  final comic = popularComics[index];
                  return Card(
                    color: const Color(0xFF1F1F1F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            child: Image.network(comic['image']!, fit: BoxFit.cover, width: double.infinity),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(comic['title']!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ch. 120', style: TextStyle(color: Colors.greenAccent[400], fontSize: 12)),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 14),
                                      Text(comic['rating']!, style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}