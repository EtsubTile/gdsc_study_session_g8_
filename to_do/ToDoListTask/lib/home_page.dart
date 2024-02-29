import 'package:flutter/material.dart';
//import 'package:to_do_list/custom_page_route.dart';
import 'package:to_do_list/list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:get/get.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SharedPreferences ?prefs;

  setupTodo() async {
    prefs = await SharedPreferences.getInstance();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('images/homePage.png')),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 190, 10, 2),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Get.to(()=> ListPageWidget(), transition: Transition.zoom);
                    // Navigator.of(context).push(
                    //   CustomPageRoute(child: const ListPageWidget())
                    //   );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListPageWidget()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all(const Size(120, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    )),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





