import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_part2/data_layer/db/cached_user_model.dart';
import 'package:provider_part2/presentation/user_screen/widgets/insert_user.dart';
import 'package:provider_part2/presentation/user_screen/widgets/update_user.dart';
import 'package:provider_part2/view_model/user_view_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init()async{
    Future.delayed(Duration.zero, (){
      Provider.of<UserViewModel>(context, listen: false).fetchUserData();
    });
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController controller3 = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InsertUser(
                    controller1: controller1,
                    controller2: controller2,
                    controller3: controller3,
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              context.read<UserViewModel>().deleteAllUserFromSql();
              context.read<UserViewModel>().fetchCachedUser();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Users",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Consumer<UserViewModel>(
              builder: (context, userView, child) {
                return userView.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: userView.cachedUsers.length,
                        itemBuilder: (BuildContext context, index) {
                          CachedUserModel cachedUser =
                              userView.cachedUsers[index];
                          return ListTile(
                            onTap: () {
                              controller1.text = cachedUser.name;
                              controller2.text = cachedUser.age.toString();
                              controller3.text = cachedUser.count.toString();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return UpdateUser(
                                    controller1: controller1,
                                    controller2: controller2,
                                    controller3: controller3,
                                    cachedUser: cachedUser,
                                  );
                                },
                              );
                            },
                            title: Text(cachedUser.name),
                            subtitle: Text("${cachedUser.age}"),
                            trailing: IconButton(
                              onPressed: () {
                                context
                                    .read<UserViewModel>()
                                    .deleteUserById(id: cachedUser.id!);
                                context.read<UserViewModel>().fetchCachedUser();
                              },
                              icon: const Icon(
                                Icons.dangerous,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
