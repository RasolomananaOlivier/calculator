import 'package:calculatorapp/aboutPage.dart';
import 'package:flutter/material.dart';

class listTileWidget extends StatelessWidget {
  listTileWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
        ),
      ),
      onTap: () {
        /**/
        if (title == 'Basic mode') {
          Navigator.pop(context);
        } else if (title == 'About') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const AboutPage(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text(
                  'Not implemented yet',
                ),
              );
            },
          );
        }
      },
    );
  }
}
