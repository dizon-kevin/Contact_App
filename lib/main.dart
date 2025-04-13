import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'variables.dart';
import 'contact.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('database'); // Ensure the box is opened in main
  runApp(CupertinoApp(
    theme: CupertinoThemeData(brightness: Brightness.dark),
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Box<dynamic> _myBox; // Declare a late variable for the box
  List<dynamic> contacts = [];

  @override
  void initState() {
    super.initState();
    _openBoxAndLoadData(); // Call a function to handle box opening and data loading
  }

  Future<void> _openBoxAndLoadData() async {
    _myBox = Hive.box('database'); // Get the already opened box
    _loadContacts();
  }

  void _loadContacts() {
    if (_myBox.get('contacts') == null) {
      print('empty list');
    } else {
      setState(() {
        contacts = _myBox.get('contacts');
        print(contacts);
      });
    }
  }

  TextEditingController _fname = TextEditingController();
  TextEditingController _lname = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _url = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.add),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return CupertinoActionSheet(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text('New Contact'),
                      CupertinoButton(
                        child: Text('Done'),
                        onPressed: () {
                          setState(() {
                            contacts.add({
                              "name": _fname.text + " " + _lname.text,
                              "phone": _phone.text,
                              "email": _email.text,
                              "url": _url.text,
                              "photo":
                              "https://scontent.fcrk1-4.fna.fbcdn.net/v/t39.30808-6/470820644_921287969980813_6651135653347092985_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeHmDNNRcYUMcQE2wBKXvV9g8y0D0Oi_9DbzLQPQ6L_0NtMTHR1wsDUcJPYZJ7DPfUf5hGyHmadFVnt_FXki-ki2&_nc_ohc=F2B8BM7Lc_QQ7kNvwGkYrYV&_nc_oc=AdlS_as0CEt-IlefJeu1Srezr2xRWLhAJVsSbzHWAEMuk2si42MhOPRVsoiUYUEdOrg&_nc_zt=23&_nc_ht=scontent.fcrk1-4.fna&_nc_gid=knZ-Cnt4b6B7T66g2Rvydg&oh=00_AfHmVHNfuIrm1jem8QwNBzzN0aRzsJHCJX6jspotl-MxGw&oe=67FFEC59",
                            });
                            _myBox.put('contacts', contacts);
                            print(_myBox.get('contacts'));
                          });

                          _fname.text = "";
                          _lname.text = "";
                          _phone.text = "";
                          _email.text = "";
                          _url.text = "";
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  message: Column(
                    children: [
                      Icon(
                        CupertinoIcons.person_circle_fill,
                        color: CupertinoColors.systemGrey,
                        size: 200,
                      ),
                      CupertinoButton(
                        child: Text('Add Photo'),
                        onPressed: () {},
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey.withOpacity(0.1)),
                        child: Column(
                          children: [
                            CupertinoTextField(
                              controller: _fname,
                              placeholder: 'First Name',
                              decoration: BoxDecoration(
                                  color:
                                  CupertinoColors.systemGrey.withOpacity(0.0)),
                            ),
                            Divider(
                              color: CupertinoColors.systemGrey.withOpacity(0.2),
                            ),
                            CupertinoTextField(
                              controller: _lname,
                              placeholder: 'Last Name',
                              decoration: BoxDecoration(
                                  color:
                                  CupertinoColors.systemGrey.withOpacity(0.0)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      CupertinoTextField(
                        controller: _phone,
                        prefix: Icon(
                          CupertinoIcons.add_circled_solid,
                          color: CupertinoColors.systemGreen,
                        ),
                        placeholder: 'Add Phone',
                        decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey.withOpacity(0.1)),
                      ),
                      SizedBox(height: 10),
                      CupertinoTextField(
                        controller: _email,
                        prefix: Icon(
                          CupertinoIcons.add_circled_solid,
                          color: CupertinoColors.systemGreen,
                        ),
                        placeholder: 'Add Email',
                        decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey.withOpacity(0.1)),
                      ),
                      SizedBox(height: 10),
                      CupertinoTextField(
                        controller: _url,
                        prefix: Icon(
                          CupertinoIcons.add_circled_solid,
                          color: CupertinoColors.systemGreen,
                        ),
                        placeholder: 'Add url',
                        decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey.withOpacity(0.1)),
                      ),
                      SizedBox(height: double.maxFinite)
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Contacts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              SizedBox(height: 15),
              CupertinoTextField(
                placeholder: 'Search',
                decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20)),
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.search,
                    color: CupertinoColors.systemGrey,
                    size: 20,
                  ),
                ),
                suffix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.mic_fill,
                    color: CupertinoColors.systemGrey,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 9, 12, 9),
                    decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey,
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      'KD',
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kevin Dizon',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'My card',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Divider(
                color: CupertinoColors.systemGrey.withOpacity(0.3),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            name = contacts[index]['name'];
                            phone = contacts[index]['phone'];
                            url = contacts[index]['url'];
                            email = contacts[index]['email'];
                            photo = contacts[index]['photo'];
                          });
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Contact()));
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(contacts[index]['name'] == " "
                                  ? contacts[index]['phone']
                                  : contacts[index]['name']),
                              Divider(
                                color: CupertinoColors.systemGrey.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}