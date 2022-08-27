import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data_layer/db/cached_user_model.dart';
import '../../../view_model/user_view_model.dart';

class UpdateUser extends StatelessWidget {
  const UpdateUser({
    Key? key,
    required this.controller1,
    required this.controller2,
    required this.controller3,
    required this.cachedUser,
  }) : super(key: key);

  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final CachedUserModel cachedUser;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("update user to Sql"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: controller1,
              decoration: const InputDecoration(
                  hintText: "Enter the name"
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: controller2,
              decoration: const InputDecoration(
                  hintText: "Enter the age"
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: controller3,
              decoration: const InputDecoration(
                  hintText: "Enter the count"
              ),
            ),
          ],
        ),
      ),
      actions: [

        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("cancel")),


        TextButton(onPressed: (){
          context.read<UserViewModel>().updateUser(id: cachedUser.id!, cachedUserModel: CachedUserModel(
            count: int.parse(controller3.text),
            name: controller1.text,
            age: int.parse(controller2.text),));
          context.read<UserViewModel>().fetchCachedUser();
          Navigator.pop(context);

        }, child: const Text("update"))
      ],
    );
  }
}