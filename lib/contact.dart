import 'package:flutter/cupertino.dart';
import 'variables.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(

        ),
        child: SafeArea(child:Column(
      children: [
        Text('$name')
      ],
    )));
  }
}
