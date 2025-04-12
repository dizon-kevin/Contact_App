import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main(){
  runApp(CupertinoApp(
    theme: CupertinoThemeData(
      brightness: Brightness.dark
    ),
    debugShowCheckedModeBanner: false,
    home: Homepage(),));
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> contacts = [
    {
      "name" : "John Doe",
      "phone" : "+1 123-456-7890",
      "emaill" : "william.paterson@my-own-personal-domain.com",
      "url" : "https://example.com/john_doe",
      "photo" : "https://www.facebook.com/photo/?fbid=977259547716988&set=a.102281275214824",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(child: Icon(CupertinoIcons.add), onPressed: (){

        }),
      ),
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
                children: [
                Row(
                  children: [
                    Text('Contacts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  ],
                ),
                  SizedBox(height: 15,),
                  CupertinoTextField(
                    placeholder: 'Search',
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    prefix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.search, color: CupertinoColors.systemGrey, size: 20,),
                    ),
                    suffix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.mic_fill, color: CupertinoColors.systemGrey, size: 20,),
                    ),
                  ),



                ],
              ),
        )));
  }
}




