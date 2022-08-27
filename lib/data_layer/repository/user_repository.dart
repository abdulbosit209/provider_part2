import 'package:provider_part2/data_layer/db/local_database.dart';
import 'package:provider_part2/data_layer/models/user_data.dart';
import 'package:provider_part2/data_layer/services/api_service.dart';
import '../db/cached_user_model.dart';

class UserRepository {
  UserRepository({required this.apiService});

  final ApiService apiService;

  Future<UserData> getUserData() => apiService.getUserData();

  //  -----------------------------------CachedUserModel------------------------------------------

  Future<List<CachedUserModel>> getAllCachedUserData() async {
    return await LocalDatabase.getAllCachedUser();
  }

  Future<CachedUserModel> insertCachedUserData({required CachedUserModel cachedUserModel}) async{
    return await LocalDatabase.insertCachedUser(cachedUserModel);
  }

  Future<CachedUserModel> insertCachedUserDataFromApi({required UserData userData}) async{
    return await LocalDatabase.insertCachedUserFromApi(userData);
  }

  Future<int> deleteAllUser()async {
    return await LocalDatabase.deleteAllCachedUser();
  }

  Future<int> deleteUserById({required int id})async {
    return await LocalDatabase.deleteCachedUserById(id);
  }

  Future<int> updateUser({required int id, required CachedUserModel cachedUserModel})async {
    return await LocalDatabase.updateCachedUser(id: id, cachedUserModel: cachedUserModel);
  }


}