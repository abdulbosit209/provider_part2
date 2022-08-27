import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_part2/data_layer/models/currency_item.dart';
import '../../view_model/curreincies_view_model.dart';
import '../user_screen/user_screen.dart';

class CurrenciesScreen extends StatefulWidget {
  const CurrenciesScreen({Key? key}) : super(key: key);

  @override
  State<CurrenciesScreen> createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init()async{
    Future.delayed(Duration.zero, (){
      Provider.of<CurrencyViewModel>(context, listen: false).fetchCurrencyList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CurrencyViewModel>(
              builder: (context, currencyViewModel, child) {
                return currencyViewModel.isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Expanded(
                  child: ListView(
                    children: List.generate(
                        currencyViewModel.currencyItems.length, (index) {
                      CurrencyItem currency =
                      currencyViewModel.currencyItems[index];
                      return ListTile(
                        title: Text(currency.title),
                        subtitle: Text(currency.code),
                        trailing: Text("${currency.cbPrice} USD"),
                      );
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text(
          "Users",
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const UsersScreen();
          }));
        },
      ),
    );
  }
}