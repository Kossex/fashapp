import 'package:app/pages/auth_page.dart';
import 'package:app/pages/chat_page.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/components/horizontal_listview.dart';
import 'package:app/components/Products.dart';
import 'package:app/pages/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Auth_Page(),
  ));
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

void signOut(BuildContext context) async {
  await googleSignIn.disconnect();
  await _auth.signOut();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const Login()),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = Container(
      height: 200.0,
      width: 350.0,
      child: Carousel(
        images: [
          const AssetImage("images/c1.jpg"),
          const AssetImage("images/m1.jpg"),
          const AssetImage("images/m2.jpg"),
          const AssetImage("images/w1.jpg"),
          const AssetImage("images/w3.jpg"),
          const AssetImage("images/w4.jpg"),
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.white.withOpacity(0.5),
        noRadiusForIndicator: true,
        autoplay: false,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: const Text('Fashapp'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_auth.currentUser?.displayName ?? ''),
              accountEmail: Text(_auth.currentUser?.email ?? ''),
              currentAccountPicture: GestureDetector(
                child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    )),
              ),
              decoration: const BoxDecoration(color: Colors.red),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person_2),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text('My orders'),
                leading: Icon(Icons.shopping_bag),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.dashboard),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text('Favorites'),
                leading: Icon(Icons.favorite),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text('About'),
                leading: Icon(Icons.help),
              ),
            ),
            InkWell(
              onTap: () => signOut(context),
              child: const ListTile(
                title: Text("Log out"),
                leading: Icon(Icons.logout),
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            imageCarousel,
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Categories',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const HorizontalList(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Recent products',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(
              height: 360,
              child: const Products(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(),
            ),
          );
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.chat),
      ),
    );
  }
}
