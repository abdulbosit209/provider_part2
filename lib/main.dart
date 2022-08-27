import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_part2/data_layer/repository/currency_repository.dart';
import 'package:provider_part2/data_layer/services/api_service.dart';
import 'package:provider_part2/presentation/currencies_screen/currencies_screen.dart';
import 'package:provider_part2/view_model/curreincies_view_model.dart';
import 'package:provider_part2/view_model/user_view_model.dart';

import 'data_layer/repository/user_repository.dart';

void main() {
  ApiService apiService = ApiService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CurrencyViewModel(
                currencyRepository:
                    CurrencyRepository(apiService: apiService))),
        ChangeNotifierProvider(
            create: (context) => UserViewModel(
                userRepository: UserRepository(apiService: apiService))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CurrenciesScreen(),
    );
  }
}
