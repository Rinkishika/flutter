
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'welcome_page.dart';

void main() async {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext mira_context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile App',
      theme: ThemeData(
        primaryColor: const Color(0xFFB58B0B), // Main color
        scaffoldBackgroundColor: const Color(0xFFB58B0B),
      ),
      initialRoute: '/',
      routes: {
        '/': (mira_context) => const mira_WelcomePage(),
        '/login': (mira_context) => mira_LoginPage(),
        '/signup': (mira_context) => const mira_SignUpPage(),
        '/home': (mira_context) => const mira_HomePage(),
        '/about': (mira_context) => const mira_AboutPage(),
        '/project': (mira_context) => const mira_ProjectPage(),
        '/contact': (mira_context) => mira_ContactPage(),
      },
    );
  }
}

// Function to encode the message in Base64
String mira_getEncodedMessage(String mira_message) {
  return base64Encode(utf8.encode(mira_message));
}
// Store user data temporarily
Map<String, String> mira_userData = {};

// Login Page
class mira_LoginPage extends StatefulWidget {
  mira_LoginPage({super.key});

  @override
  _mira_LoginPageState createState() => _mira_LoginPageState();
}

class _mira_LoginPageState extends State<mira_LoginPage> {
  final TextEditingController mira_usernameController = TextEditingController();
  final TextEditingController mira_passwordController = TextEditingController();
  bool mira_isObscured = true;

  @override
  Widget build(BuildContext mira_context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Use \nyou're!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(mira_context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),

          // Username TextField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              controller: mira_usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Password TextField
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: mira_passwordController,
              obscureText: mira_isObscured,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    mira_isObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      mira_isObscured = !mira_isObscured;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Continue Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB58B0B), // Mustard color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  if (mira_usernameController.text == mira_userData['username'] &&
                      mira_passwordController.text == mira_userData['password']) {
                    Navigator.pushNamed(mira_context, '/home');
                  } else {
                    ScaffoldMessenger.of(mira_context).showSnackBar(
                      const SnackBar(content: Text('INVALID USERNAME OR PASSWORD')),
                    );
                  }
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Sign-Up Page
class mira_SignUpPage extends StatefulWidget {
  const mira_SignUpPage({super.key});

  @override
  _mira_SignUpPageState createState() => _mira_SignUpPageState();
}

class _mira_SignUpPageState extends State<mira_SignUpPage> {
  final TextEditingController mira_phoneController = TextEditingController();
  final TextEditingController mira_usernameController = TextEditingController();
  final TextEditingController mira_passwordController = TextEditingController();
  DateTime? mira_selectedDate;
  bool mira_isObscured = true; // Variable to manage password visibility

  Future<void> mira_selectDate(BuildContext mira_context) async {
    final DateTime? mira_picked = await showDatePicker(
      context: mira_context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (mira_picked != null && mira_picked != mira_selectedDate) {
      setState(() {
        mira_selectedDate = mira_picked;
      });
    }
  }

  bool mira_isFormValid() {
    return mira_phoneController.text.isNotEmpty &&
        mira_usernameController.text.isNotEmpty &&
        mira_passwordController.text.isNotEmpty &&
        mira_selectedDate != null;
  }

  void mira_handleSignUp() {
    if (mira_isFormValid()) {
      mira_userData = {
        'phone': mira_phoneController.text,
        'username': mira_usernameController.text,
        'password': mira_passwordController.text,
      };
      Navigator.pushNamed(context, '/home');
      print("Data saved successfully.");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PLEASE FILL UP THE FIELDS')),
      );
    }
  }

  @override
  Widget build(BuildContext mira_context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top header with "Let's Sign Up!" text
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 70),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFd4a02c),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Let's\nSign Up!",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(mira_context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Input fields for Phone Number, Username, Birthday, and Password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                TextField(
                  controller: mira_phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: mira_usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Birthday field with date picker
                GestureDetector(
                  onTap: () => mira_selectDate(mira_context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mira_selectedDate == null
                              ? 'Birthday'
                              : '${mira_selectedDate!.year}-${mira_selectedDate!.month}-${mira_selectedDate!.day}',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password TextField with "Show Password" option
                TextField(
                  controller: mira_passwordController,
                  obscureText: mira_isObscured,
                  decoration: InputDecoration(
                    hintText: 'Create Password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        mira_isObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          mira_isObscured = !mira_isObscured;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Continue button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFd4a02c),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 7.5),
                    ),
                    onPressed: mira_handleSignUp,
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Log In link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(mira_context, '/login');
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Home Page
class mira_HomePage extends StatelessWidget {
  const mira_HomePage({super.key});

  @override
  Widget build(BuildContext mira_context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back icon
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true, // Center the title
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1), // White background color
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/logOut.png'), // Logout icon image path
            onPressed: () => Navigator.pushNamed(mira_context, '/'),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFB58B0B), // Background color
        alignment: Alignment.center, // Center the content vertically and horizontally
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hello \n World",
              textAlign: TextAlign.center, // Center-align the text
              style: TextStyle(
                fontSize: 105,
                color: Colors.white,
                fontFamily: 'Times New Roman', // Use specified font
              ),
            ),
            SizedBox(height: 10),
            Text(
              "It’s Mira",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontFamily: 'Serif', // Use specified font
              ),
            ),
            Text(
              "BACHELOR OF SCIENCE IN\n INFORMATION TECHNOLOGY",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFB58B0B), // Match background color
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Image.asset('assets/icons/home.png'), // Home icon path
              onPressed: () {}, // Stay on the home page
            ),
            IconButton(
              icon: Image.asset('assets/icons/about.png'), // About icon path
              onPressed: () => Navigator.pushNamed(mira_context, '/about'),
            ),
            IconButton(
              icon: Image.asset('assets/icons/project.png'), // Project icon path
              onPressed: () => Navigator.pushNamed(mira_context, '/project'),
            ),
            IconButton(
              icon: Image.asset('assets/icons/contact.png'), // Contact icon path
              onPressed: () => Navigator.pushNamed(mira_context, '/contact'),
            ),
          ],
        ),
      ),
    );
  }
}

// About Page
class mira_AboutPage extends StatelessWidget {
  const mira_AboutPage({super.key});

  @override
  Widget build(BuildContext mira_context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),  // Brownish background color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(mira_context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFB58B0B), // Match background color
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image and Bio
              Center(
                child: Image.asset(
                  'assets/miraface.jpg', // Replace with actual path
                  width: 500,
                  height: 300,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text(
                  "Hi! I am Mirasol Tarle Jalandoni, \"Mirasol\" means A fully grown beautiful sunflower(charr). Also just call me Mira or Love? hahaha, A 21 years of age born in March 16, 2003. A 3rdyr BSIT student currently studying at DNSC. Did you know? that, I did not choose this program as I was also forced from one of my family to take this program because of the salary,Yes! It's a salary for motivation hahaha, I haven't experience about computer, the programming languages and coding, actually I don’t have a choices what should I take a program and so I grab it, Hey! don't understimate this program, girl, I swear it's really difficult for me because I have no experience with it. But now I'm in my 3rd year college era, it took me a long time to learn but not everything and I'm not that good either. And yes you can really learn but you can't learn everything in school because they don't teach everything.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Serif', // Use the specified font
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // Educational Attainment Section
              const Row(
                children: [
                  Icon(Icons.school, color: Colors.black, size: 24), // Icon for educational attainment
                  SizedBox(width: 8),
                  Text(
                    "Educational",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                    ),
                  ),
                ],
              ),
              const Text(
                "Attainment",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: 'Serif',
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 20),

              // Educational List
              const Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "• 2008-2015 - A.O FLLOIRENDO ELEMENTARY SCHOOL",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Serif',
                      ),
                    ),
                    Text(
                      "• 2015-2019 - A.O FLOIRENDO NATIONAL HIGH SCHOOL",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Serif',
                      ),
                    ),
                    Text(
                      "• 2019-2021 - A.O FLOIRENDO NATIONAL HIGH SCHOOL SHS",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Serif',
                      ),
                    ),
                    Text(
                      "• 2022-2023 - DAVAO DEL NORTE STATE COLLEGE",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Serif',
                      ),
                    ),
                    Text(
                      "• 2023-2024 - DAVAO DEL NORTE STATE COLLEGE",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Serif',
                      ),
                    ),
                    Text(
                      "• 2024-2025 - DAVAO DEL NORTE STATE COLLEGE",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Serif',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Logos of Schools
              Column(
                children: [
                  Image.asset(
                    'assets/logo2.png', // Replace with actual logo paths
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/logo1.png', // Replace with actual logo paths
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/DNSC-logo.png', // Replace with actual logo paths
                    width: 80,
                    height: 80,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Project Page
class mira_ProjectPage extends StatelessWidget {
  const mira_ProjectPage({super.key});

  // Function to open URLs
  void mira_launchURL(String mira_url) async {
    final Uri mira_uri = Uri.parse(mira_url);
    if (await canLaunchUrl(mira_uri)) {
      await launchUrl(mira_uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $mira_url';
    }
  }

  @override
  Widget build(BuildContext mira_context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB58B0B),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
        title: const Text(
          "Project",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black, // Optional: set text color
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Optional: set icon color
          onPressed: () {
            Navigator.pop(mira_context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "My Project",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '"Whether you\'re developing software, managing databases, configuring networks, securing systems, training AI, administering servers, building games, or creating websites and so many more, remember: every project you tackle brings the future closer, one innovation at a time. This some of our/my works."',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            // Enhanced TESDA Project
            Center(
              child: GestureDetector(
                onTap: () {
                  mira_launchURL('https://lynxguerba.github.io/Tesda-Final_Project/');
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/tesda.jpg',
                      height: 150,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Enhanced TESDA",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF6B800),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Personal Website Project
            Center(
              child: GestureDetector(
                onTap: () {
                  mira_launchURL('https://rinkishika.github.io/personalWeb/');
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/personal.jpg',
                      height: 150,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Personal WebSite",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF6B800),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // "See More" Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  mira_launchURL('https://github.com/Rinkishika/meringue');
                },
                child: const Text(
                  "SEE MORE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Contact Pages
class  mira_ContactPage extends StatelessWidget {
  final String miraMessage = "Contact Mira for more information.";
  final TextEditingController miraNameController = TextEditingController();
  final TextEditingController miraEmailController = TextEditingController();
  final TextEditingController miraPhoneController = TextEditingController();
  final TextEditingController miraMessageController = TextEditingController();

  mira_ContactPage({super.key});

  // Function to open Gmail with pre-filled email including user input
  void _sendEmailMira() async {
    final Uri miraEmailUri = Uri(
      scheme: 'mailto',
      path: 'jalandonitarlimira@gmail.com',
      queryParameters: {
        'subject': 'Contact Inquiry',
        'body': 'Name: ${miraNameController.text}\n'
                'Email: ${miraEmailController.text}\n'
                'Phone: ${miraPhoneController.text}\n'
                'Message: ${miraMessageController.text}'
      },
    );
    if (await canLaunchUrl(miraEmailUri)) {
      await launchUrl(miraEmailUri);
    } else {
      throw 'Could not launch email client';
    }
  }

  // Function to launch external URLs
  void _launchURLMira(String miraUrl) async {
    final Uri miraUri = Uri.parse(miraUrl);
    if (await canLaunchUrl(miraUri)) {
      await launchUrl(miraUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $miraUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB58B0B),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Contact",
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/Lock.png', height: 30, width: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CipherPageMira(cipherMessageMira: ""),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "GET IN TOUCH",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: miraNameController,
                decoration: const InputDecoration(
                  hintText: 'Your Name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: miraEmailController,
                decoration: const InputDecoration(
                  hintText: 'Your Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: miraPhoneController,
                decoration: const InputDecoration(
                  hintText: 'Your Phone Number',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: miraMessageController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Your Message',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendEmailMira,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text("Send Now"),
              ),
              const SizedBox(height: 50),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        "Colosas, Davao del Sur",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        "+639079403731",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        "jalandonitarlimira@gmail.com",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset('assets/icons/tiktok.png', height: 24, width: 24),
                    onPressed: () => _launchURLMira("https://www.tiktok.com/@qual_8?is_from_webapp=1&sender_device=pcs"),
                  ),
                  IconButton(
                    icon: Image.asset('assets/icons/instagram.png', height: 30, width: 30),
                    onPressed: () => _launchURLMira("https://www.instagram.com/meringue_0316/"),
                  ),
                  IconButton(
                    icon: Image.asset('assets/icons/facebook.png', height: 30, width: 30),
                    onPressed: () => _launchURLMira("https://www.facebook.com/Mirakyutt.3361"),
                  ),
                  IconButton(
                    icon: Image.asset('assets/icons/telegram.png', height: 30, width: 30),
                    onPressed: () => _launchURLMira("https://web.telegram.org/k/"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _launchURLMira("https://www.facebook.com/Mirakyutt.3361"),
                child: const Text(
                  "2024 All Rights Reserved. Design by Mira",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Cipher Page
class CipherPageMira extends StatefulWidget {
  final String cipherMessageMira;
  const CipherPageMira({super.key, required this.cipherMessageMira});

  @override
  _CipherPageStateMira createState() => _CipherPageStateMira();
}

class _CipherPageStateMira extends State<CipherPageMira> {
  final TextEditingController miraCipherController = TextEditingController();
  String miraDisplayedMessage = "";
  String miraSelectedCipher = "Caesar";

  void _showCiphertextMira() {
    setState(() {
      final miraInput = miraCipherController.text;
      miraDisplayedMessage = "Cyphertext: ${_applyCipherMira(miraInput)}";
    });
  }

  String _applyCipherMira(String miraInput) {
    switch (miraSelectedCipher) {
      case "Caesar":
        return _caesarCipherMira(miraInput, 3);
      case "Vigenère":
        return _vigenereCipherMira(miraInput, "KEY");
      case "Atbash":
        return _atbashCipherMira(miraInput);
      default:
        return miraInput;
    }
  }

  String _caesarCipherMira(String miraText, int miraShift) {
    return String.fromCharCodes(
      miraText.runes.map((int miraRune) {
        if (miraRune >= 65 && miraRune <= 90) return ((miraRune - 65 + miraShift) % 26) + 65;
        if (miraRune >= 97 && miraRune <= 122) return ((miraRune - 97 + miraShift) % 26) + 97;
        return miraRune;
      }),
    );
  }

  String _vigenereCipherMira(String miraText, String miraKey) {
    final miraBuffer = StringBuffer();
    miraKey = miraKey.padRight(miraText.length, miraKey);
    for (int i = 0; i < miraText.length; i++) {
      final miraRune = miraText.codeUnitAt(i);
      final miraShift = miraKey.codeUnitAt(i % miraKey.length) - 65;

      if (miraRune >= 65 && miraRune <= 90) {
        miraBuffer.writeCharCode(((miraRune - 65 + miraShift) % 26) + 65);
      } else if (miraRune >= 97 && miraRune <= 122) {
        miraBuffer.writeCharCode(((miraRune - 97 + miraShift) % 26) + 97);
      } else {
        miraBuffer.writeCharCode(miraRune);
      }
    }
    return miraBuffer.toString();
  }

  String _atbashCipherMira(String miraText) {
    return String.fromCharCodes(
      miraText.runes.map((int miraRune) {
        if (miraRune >= 65 && miraRune <= 90) return 90 - (miraRune - 65);
        if (miraRune >= 97 && miraRune <= 122) return 122 - (miraRune - 97);
        return miraRune;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB58B0B),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Cipher",
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Enter a message to encode:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: miraCipherController,
                decoration: const InputDecoration(
                  hintText: 'Enter text to encode',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: miraSelectedCipher,
                items: const [
                  DropdownMenuItem(value: "Caesar", child: Text("Caesar")),
                  DropdownMenuItem(value: "Vigenère", child: Text("Vigenère")),
                  DropdownMenuItem(value: "Atbash", child: Text("Atbash")),
                ],
                onChanged: (String? miraValue) {
                  setState(() {
                    miraSelectedCipher = miraValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showCiphertextMira,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text("Encode"),
              ),
              const SizedBox(height: 20),
              Text(
                miraDisplayedMessage,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
