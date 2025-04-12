import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'variables.dart';
import 'contact.dart';

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
      "email" : "william.paterson@my-own-personal-domain.com",
      "url" : "https://facebook.com/john_doe",
      "photo" : "https://www.facebook.com/photo/?fbid=977259547716988&set=a.102281275214824",
    },

    {
      "name" : "Kevin Dizon",
      "phone" : "+1 123-456-7890",
      "email" : "william.paterson@my-own-personal-domain.com",
      "url" : "https://facebook.com/john_doe",
      "photo" : "https://www.facebook.com/photo/?fbid=977259547716988&set=a.102281275214824",
    },

    {
      "name" : "John Doe",
      "phone" : "+1 123-456-7890",
      "email" : "william.paterson@my-own-personal-domain.com",
      "url" : "https://facebook.com/john_doe",
      "photo" : "https://www.facebook.com/photo/?fbid=977259547716988&set=a.102281275214824",
    },

    {
      "name" : "Kevin Dizon",
      "phone" : "+1 123-456-7890",
      "email" : "william.paterson@my-own-personal-domain.com",
      "url" : "https://facebook.com/john_doe",
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
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(12,9,12,9),

                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey,
                          borderRadius: BorderRadius.circular(50)
                        ),
                      child: Text('KD', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kevin Dizon', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('My card', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),)

                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Divider(color: CupertinoColors.systemGrey.withOpacity(0.3),),
                  Expanded(child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, int index){
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              name = contacts[index]['name'];
                              phone = contacts[index]['phone'];
                              url = contacts[index]['url'];
                              email = contacts[index]['email'];
                              photo = contacts[index]['photo'];
                            });
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => Contact()));

                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(contacts[index]['name']),
                                Divider(color: CupertinoColors.systemGrey.withOpacity(0.3),),
                              ],
                            ),
                          ),
                        );

                  })),
                ],
              ),
        )));
  }
}