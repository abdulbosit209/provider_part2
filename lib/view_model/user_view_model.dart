import 'package:flutter/foundation.dart';
import 'package:provider_part2/data_layer/db/cached_user_model.dart';
import 'package:provider_part2/data_layer/models/user_data.dart';
import 'package:provider_part2/data_layer/repository/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel({required this.userRepository});

  final UserRepository userRepository;

  List<CachedUserModel> cachedUsers = [];
  late UserData userData;

  bool isLoading = false;

  void fetchCachedUser() async {
    cachedUsers = await userRepository.getAllCachedUserData();
    notifyListeners();
  }

  void fetchUserData() async {
    isLoading = true;
    notifyListeners();
    userData = await userRepository.getUserData();
    await userRepository.insertCachedUserDataFromApi(userData: userData);
    cachedUsers = await userRepository.getAllCachedUserData();
    isLoading = false;
    notifyListeners();
  }

  void insertUserToSql({required CachedUserModel cachedUserModel})async{
    await userRepository.insertCachedUserData(cachedUserModel: cachedUserModel);
    notifyListeners();
  }

  void deleteAllUserFromSql()async{
    isLoading = true;
    notifyListeners();
    await userRepository.deleteAllUser();
    isLoading = false;
    notifyListeners();
  }

  void deleteUserById({required int id})async{
    await userRepository.deleteUserById(id: id);
    notifyListeners();
  }

  void updateUser({required int id, required CachedUserModel cachedUserModel})async{
    await userRepository.updateUser(cachedUserModel: cachedUserModel, id: id);
    notifyListeners();
  }

}