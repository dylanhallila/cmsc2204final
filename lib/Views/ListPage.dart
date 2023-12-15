import 'package:flutter/material.dart';
import 'package:hallila_final/Models/Character.dart';
import 'package:hallila_final/Repositories/UserClient.dart';
import 'package:hallila_final/Views/DetailPage.dart';

class ListPage extends StatefulWidget {
  List<Character> characters;

  ListPage({Key? key, required this.characters}) : super(key: key);

  final UserClient userClient = UserClient();

  @override
  State<ListPage> createState() => _ListPageState(characters);
}

bool _loading = false;

class _ListPageState extends State<ListPage> {
  _ListPageState(characters);

  late List<Character> characters = widget.characters;

  void onReloadButtonPress() {
    getCharacters();
  }

  void getCharacters() {
    setState(() {
      _loading = true;
      widget.userClient
          .GetCharactersAsync()
          .then((response) => onGetCharactersSuccess(response));
    });
  }

  void onGetCharactersSuccess(List<Character>? newCharacters) {
    setState(() {
      if (newCharacters != null) {
        characters = newCharacters;
      }

      _loading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Characters Reloaded")));
    });
  }

  void onCharacterTap(Character character) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(character: character)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("View Characters"),
      ),
      body: _loading
          ? Center(
              child: SizedBox.expand(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/starrysky.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      Text("Loading...",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 50,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/starrysky.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                              children: characters.map((character) {
                            return Padding(
                              padding: const EdgeInsets.all(3),
                              child: GestureDetector(
                                onTap: () => onCharacterTap(character),
                                child: Card(
                                  child: Column(
                                    children: <Widget>[
                                      Text(character.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("${character.height} cm",
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const SizedBox(width: 12),
                                          Text("${character.mass} kg",
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      Text("Born: ${character.birthYear}",
                                          style: const TextStyle(fontSize: 16)),
                                      Text("Gender: ${character.gender}",
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList()),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: onReloadButtonPress,
                          child: const Text("Reload")),
                    ],
                  )),
            ),
    );
  }
}
