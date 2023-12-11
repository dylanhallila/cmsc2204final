import 'package:dio/dio.dart';
import 'package:hallila_final/Models/LoginStructure.dart';
import 'package:hallila_final/Models/User.dart';
import './DataService.dart';

const String BaseUrl = "https://swapi.dev/api";

class UserClient {
  final _dio = Dio(BaseOptions(baseUrl: BaseUrl));
  DataService _dataService = DataService();

  void InitializeUsers() {
    _dataService.AddItem("DylanHallila", "password1");
  }

  Future<String?> Login(LoginStructure user) async {
    try {
      var foundUserPassword = await _dataService.TryGetItem(user.username);

      if (foundUserPassword != null) {
        User foundUser = User(user.username, foundUserPassword);

        if (user.password == foundUser.Password) {
          return "success";
        } else {
          return "password";
        }
      } else {
        return "username";
      }
    } catch (error) {
      print(error);
      return null;
    }
  }
}
