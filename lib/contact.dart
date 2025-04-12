import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

        Image.network(photo, width: double.infinity, fit: BoxFit.fill, height: 300,),
        Text(name, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Container(
                  margin: EdgeInsets.fromLTRB(15,0,15,10),
                  padding: EdgeInsets.fromLTRB(15,0,15,10),
                  decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      CupertinoButton(child: Icon(CupertinoIcons.bubble_middle_bottom_fill, color: CupertinoColors.white,), onPressed: (){

                      }),
                      Text('Message', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)

                    ],
                  ),
                ),
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.fromLTRB(15,0,15,10),
                  padding: EdgeInsets.fromLTRB(15,0,15,10),
                  decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      CupertinoButton(child: Icon(CupertinoIcons.phone_solid, color: CupertinoColors.white,), onPressed: (){

                      }),
                      Text('Call', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)

                    ],
                  ),
                ),
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.fromLTRB(15,0,15,10),
                  padding: EdgeInsets.fromLTRB(15,0,15,10),
                  decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      CupertinoButton(child: Icon(CupertinoIcons.bubble_middle_bottom_fill, color: CupertinoColors.white,), onPressed: (){

                      }),
                      Text('Message', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)

                    ],
                  ),
                ),
              ),
              Container(
                child: Container(
                  margin: EdgeInsets.fromLTRB(15,0,15,10),
                  padding: EdgeInsets.fromLTRB(15,0,15,10),
                  decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      CupertinoButton(child: Icon(CupertinoIcons.bubble_middle_bottom_fill, color: CupertinoColors.white,), onPressed: (){

                      }),
                      Text('Message', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)

                    ],
                  ),
                ),
              ),

            ],
          ),
        )
      ],
    )));
  }
}
