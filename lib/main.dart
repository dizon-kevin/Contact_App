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
      "photo" : "https://scontent.fcrk1-4.fna.fbcdn.net/v/t39.30808-6/470820644_921287969980813_6651135653347092985_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeHmDNNRcYUMcQE2wBKXvV9g8y0D0Oi_9DbzLQPQ6L_0NtMTHR1wsDUcJPYZJ7DPfUf5hGyHmadFVnt_FXki-ki2&_nc_ohc=F2B8BM7Lc_QQ7kNvwGkYrYV&_nc_oc=AdlS_as0CEt-IlefJeu1Srezr2xRWLhAJVsSbzHWAEMuk2si42MhOPRVsoiUYUEdOrg&_nc_zt=23&_nc_ht=scontent.fcrk1-4.fna&_nc_gid=knZ-Cnt4b6B7T66g2Rvydg&oh=00_AfHmVHNfuIrm1jem8QwNBzzN0aRzsJHCJX6jspotl-MxGw&oe=67FFEC59",
    },

    {
      "name" : "Kevin Dizon",
      "phone" : "+1 123-456-7890",
      "email" : "william.paterson@my-own-personal-domain.com",
      "url" : "https://facebook.com/john_doe",
      "photo" : "https://lh3.googleusercontent.com/UxsYFA_2a5WFpoL3TvTr9f7CsnTUFiRRHVCRUdZXCfoOeKQzs51V96eQVWRs1qi1TS_DpkC1PJ-BuUdkuOXrQg59SGjyPH0O-rGrYKlvCNGs2mN9=w960-rj-nu-e365",
    },

    {
      "name" : "John Doe",
      "phone" : "+1 123-456-7890",
      "email" : "william.paterson@my-own-personal-domain.com",
      "url" : "https://facebook.com/john_doe",
      "photo" : "https://plus.unsplash.com/premium_photo-1689530775582-83b8abdb5020?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },

    {
      "name" : "Kevin Dizon",
      "phone" : "+1 123-456-7890",
      "email" : "william.paterson@my-own-personal-domain.com",
      "url" : "https://facebook.com/john_doe",
      "photo" : "https://plus.unsplash.com/premium_photo-1689530775582-83b8abdb5020?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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