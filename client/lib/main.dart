import 'package:client/settings_page.dart';
import 'package:client/home_page.dart';
import 'package:client/library_page.dart';
import 'package:client/signin_page.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'new_page.dart';
import 'search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          textTheme: TextTheme(
            titleLarge: GoogleFonts.raleway(),
            displayLarge: GoogleFonts.raleway(),
            bodyLarge: GoogleFonts.raleway(),
            bodyMedium: GoogleFonts.raleway(),
            bodySmall: GoogleFonts.raleway(),
            labelLarge: GoogleFonts.raleway(),
            labelMedium: GoogleFonts.raleway(fontWeight: FontWeight.bold),
          )),
      home: const AuthGate(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.onlyShowSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: const Text(
          "FitSync",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                  ),
                ),
              );
            },
            tooltip: "Account Details",
            color: Colors.white,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search_rounded),
            icon: Icon(Icons.search_outlined),
            label: 'Discover',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add_circle_rounded),
            icon: Icon(Icons.add_circle_outline_outlined),
            label: 'New',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmarks_rounded),
            icon: Icon(Icons.bookmarks_outlined),
            label: 'Saved',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings_rounded),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const HomePage(),
        const SearchPage(),
        const NewPage(),
        const LibraryPage(),
        const SettingsPage()
      ][currentPageIndex],
    );
  }
}
