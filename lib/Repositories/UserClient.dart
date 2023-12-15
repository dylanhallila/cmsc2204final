import 'package:dio/dio.dart';
import 'package:hallila_final/Models/Character.dart';
import 'package:hallila_final/Models/LoginStructure.dart';
import 'package:hallila_final/Models/User.dart';
import './DataService.dart';

const String BaseUrl = "https://swapi.dev/api";

class UserClient {
  final _dio = Dio(BaseOptions(baseUrl: BaseUrl));
  final DataService _dataService = DataService();

  void InitializeUsers() {
    //this is a default user added into the app on startup
    _dataService.AddItem("DylanHallila", "password1");
  }

  Future<String?> Login(LoginStructure user) async {
    try {
      var foundUserPassword = await _dataService.TryGetItem(user.username);

      if (foundUserPassword != null) {
        User foundUser = User(user.username, foundUserPassword);

        if (user.password == foundUser.password) {
          return "success";
        } else {
          return "password"; //password error
        }
      } else {
        return "username"; //username error
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<Character>?> GetCharactersAsync() async {
    try {
      var response = await _dio.get("/people/");
      List<Character>? characters = List.empty(growable: true);
      var loadNextPage =
          2; //when this reaches 0, the loop will stop loading new pages
      var pageNumber = 1; //the page number to load

      if (response != null) {
        while (loadNextPage != 0) {
          for (var character in response.data["results"]) {
            characters.add(Character(
                character["name"],
                character["height"],
                character["mass"],
                character["hair_color"],
                character["skin_color"],
                character["eye_color"],
                character["birth_year"],
                character["gender"]));
          }

          pageNumber++;

          if (loadNextPage == 2) {
            response = await _dio.get("/people/?page=$pageNumber");
          }

          if (response.data["next"] == null) {
            //decrement loadNextPage value if no next page exists
            loadNextPage -= 1;
          }
        }

        return characters;
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
