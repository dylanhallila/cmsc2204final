import 'package:flutter/material.dart';
import 'package:hallila_final/Models/LoginStructure.dart';
import 'package:hallila_final/Models/User.dart';
import 'package:hallila_final/Repositories/DataService.dart';
import 'package:hallila_final/Repositories/UserClient.dart';
import 'package:hallila_final/Views/AboutPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Hallila Star Wars App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final UserClient userClient = UserClient();
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool _loading = false;
String _appVersion = "1.0.0";
UserClient _userClient = UserClient();

class _MyHomePageState extends State<MyHomePage> {
  String apiVersion = "";
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userClient.InitializeUsers();
  }

  void onLoginButtonPress() {
    setState(() {
      _loading = true;
      LoginStructure user =
          LoginStructure(usernameController.text, passwordController.text);

      widget.userClient
          .Login(user)
          .then((response) => onLoginCallCompleted(response));
    });
  }

  void onAboutTap() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AboutPage()));
    });
  }

  void onLoginCallCompleted(var response) {
    if (response == "password") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Incorrect Password")));
    } else if (response == "username") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username Doesn't Exist")));
    } else if (response == "success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Success")));
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text("Please Sign In"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(hintText: "Username"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: onLoginButtonPress,
                        child: const Text("Login"))
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: onAboutTap,
                    child: const Text("About",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Text(_appVersion),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
