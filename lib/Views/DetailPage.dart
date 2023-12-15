import 'package:flutter/material.dart';
import 'package:hallila_final/Models/Character.dart';
import 'package:hallila_final/Repositories/UserClient.dart';

class DetailPage extends StatefulWidget {
  final Character character;

  DetailPage({Key? key, required this.character}) : super(key: key);

  final UserClient userClient = UserClient();

  @override
  State<DetailPage> createState() => _ListPageState(character);
}

bool _loading = false;

class _ListPageState extends State<DetailPage> {
  _ListPageState(characters);

  late Character character = widget.character;

  void onReturnButtonPress() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("View ${character.name}"),
      ),
      body: _loading
          ? const Column(
              children: [
                CircularProgressIndicator(),
                Text("Loading..."),
              ],
            )
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/starrysky.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                      child: Column(
                    children: [
                      Text(
                        character.name,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${character.height} cm',
                              style: const TextStyle(fontSize: 24)),
                          const SizedBox(width: 16),
                          Text('${character.mass} kg',
                              style: const TextStyle(fontSize: 24)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Born: ${character.birthYear}',
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 16),
                          Text('Gender: ${character.gender}',
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Hair: ${character.hairColor}',
                              style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 16),
                          Text('Eyes: ${character.eyeColor}',
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Skin: ${character.skinColor}',
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: onReturnButtonPress,
                          child: const Text("Return to Characters Page"))
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
