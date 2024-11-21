import 'package:flutter/material.dart';

class mira_WelcomePage extends StatelessWidget {
  const mira_WelcomePage({super.key});

  @override
  Widget build(BuildContext mira_context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFd4a02c), // Top mustard yellow color
              Colors.black,      // Bottom black color
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 145,
                backgroundImage: AssetImage('assets/circleAvatar.jpg'),
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 60,
                  color: Color.fromARGB(255, 217, 157, 28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "WEB PROFILE APP",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "LOG IN",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(mira_context, '/login');
                  },
                  child: const Text(
                    "Use username/password",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Placeholder for additional login methods (e.g., social login)
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(mira_context, '/signup');
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
