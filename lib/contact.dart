import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'variables.dart';
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool _isEditing = false;
  late Box<dynamic> _myBox; // Add reference to Hive box
  int? _contactIndex; // To track which contact is being edited
  final ImagePicker _picker = ImagePicker();
  String? _selectedImageBase64;

  // Controllers for text fields
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _urlController;
  List<Map<String, dynamic>> _phoneNumbersEditing = [];

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box('database'); // Get the opened box
    _nameController = TextEditingController(text: name);
    _emailController = TextEditingController(text: email);
    _urlController = TextEditingController(text: url);

    // Store the current photo in the selected image base64 if it's already in base64 format
    if (isBase64) {
      _selectedImageBase64 = photo;
    }

    // Find contact index in the database
    _findContactIndex();

    // Initialize phone number controllers
    if (phoneNumbers.isNotEmpty) {
      _phoneNumbersEditing = List<Map<String, dynamic>>.from(phoneNumbers);
    } else if (phone.isNotEmpty) {
      _phoneNumbersEditing = [{'label': 'mobile', 'number': phone}];
    }
  }

  // Find the index of the current contact in the Hive database
  void _findContactIndex() {
    List<dynamic> contacts = _myBox.get('contacts') ?? [];
    for (int i = 0; i < contacts.length; i++) {
      if (contacts[i]['name'] == name && contacts[i]['email'] == email) {
        _contactIndex = i;
        break;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Save changes
        _saveChanges();
      }
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 75, // Reduce quality to save storage space
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          // Convert image to base64 string for storage
          _selectedImageBase64 = base64Encode(bytes);
          isBase64 = true; // Update the global flag
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Method to get image widget from base64 string or URL
  Widget _getImageWidget() {
    if (_selectedImageBase64 != null && _selectedImageBase64!.isNotEmpty) {
      try {
        return Image.memory(
          base64Decode(_selectedImageBase64!),
          width: double.infinity,
          fit: BoxFit.cover,
          height: 300,
        );
      } catch (e) {
        print('Error decoding image: $e');
      }
    } else if (isBase64) {
      return Image.memory(
        base64Decode(photo),
        width: double.infinity,
        fit: BoxFit.cover,
        height: 300,
      );
    }

    // Return network image if not base64
    return Image.network(
      photo,
      width: double.infinity,
      fit: BoxFit.cover,
      height: 300,
    );
  }

  void _saveChanges() {
    // Update the global variables with new values
    name = _nameController.text;
    email = _emailController.text;
    url = _urlController.text;

    // Update photo if a new one was selected
    if (_selectedImageBase64 != null) {
      photo = _selectedImageBase64!;
      isBase64 = true;
    }

    // Update phone numbers
    if (_phoneNumbersEditing.isNotEmpty) {
      phoneNumbers = List<Map<String, dynamic>>.from(_phoneNumbersEditing);
      phone = _phoneNumbersEditing[0]['number'] ?? '';
    }

    // Update in Hive database if we found this contact
    if (_contactIndex != null) {
      List<dynamic> contacts = _myBox.get('contacts') ?? [];

      // Update the contact at the found index
      contacts[_contactIndex!] = {
        "name": name,
        "company": contacts[_contactIndex!]['company'] ?? '', // Preserve existing company if any
        "phone": phone,
        "phoneNumbers": phoneNumbers,
        "email": email,
        "url": url,
        "photo": photo,
        "isBase64": isBase64,
      };

      // Save back to Hive
      _myBox.put('contacts', contacts);
      print('Contact updated in Hive database at index $_contactIndex');
    } else {
      print('Contact not found in database, could not update.');
    }
  }

  void _addPhoneNumber() {
    setState(() {
      _phoneNumbersEditing.add({'label': 'mobile', 'number': ''});
    });
  }

  void _removePhoneNumber(int index) {
    setState(() {
      _phoneNumbersEditing.removeAt(index);
    });
  }

 @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Display image with the ability to update
                  _getImageWidget(),
                  Positioned(
                      top: -2,
                      left: -15,
                      child: Row(
                        children: [
                          CupertinoButton(
                              child: Icon(CupertinoIcons.chevron_back, color: CupertinoColors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          )
                        ],
                      )
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          _isEditing ? CupertinoIcons.check_mark : CupertinoIcons.pencil,
                          color: CupertinoColors.white,
                        ),
                        onPressed: _toggleEditMode,
                      )
                  ),
                  // Add Change Photo button if in editing mode
                  if (_isEditing)
                    Positioned(
                        top: 60,
                        right: 10,
                        child: CupertinoButton(
                          padding: EdgeInsets.all(10),
                          color: CupertinoColors.systemGrey.withOpacity(0.5),
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.camera, color: CupertinoColors.white, size: 16),
                              SizedBox(width: 5),
                              Text("Change Photo", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          onPressed: _pickImage,
                        )
                    ),
                        Container(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5,0,5,0),
                            padding: EdgeInsets.fromLTRB(10,0,10,5),
                            decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                CupertinoButton(child: Icon(CupertinoIcons.phone_solid, color: CupertinoColors.white,), onPressed: () async{
                                  final Uri uri = await Uri.parse('tel: $phone');
                                  await launchUrl(uri);
                                }),
                                Text('Call', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)
              
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5,0,5,0),
                            padding: EdgeInsets.fromLTRB(10,0,10,5),
                            decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                CupertinoButton(child: Icon(CupertinoIcons.video_camera_solid, color: CupertinoColors.white,), onPressed: (){

                                }),
                                Text('Video', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)
              
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5,0,5,0),
                            padding: EdgeInsets.fromLTRB(10,0,10,5),
                            decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              children: [
                                CupertinoButton(child: Icon(CupertinoIcons.mail_solid, color: CupertinoColors.white,), onPressed: () async{
                                  final Uri uri = await Uri.parse('mailto: $email');
                                  await launchUrl(uri);
                                }),
                                Text('Mail', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),)
              
                              ],
                            ),
                          ),
                        ),
              
                      ],
                    ),

          )        ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async{
                  final Uri uri = await Uri.parse('tel: $phone ');
                  await launchUrl(uri);

        },
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CupertinoColors.systemGrey.withOpacity(0.3)
                          ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('phone', style: TextStyle(fontSize: 13),),
                      Text('$phone', style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () async{
                  final Uri uri = await Uri.parse('tel: $phone ');
                  await launchUrl(uri);

                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: CupertinoColors.systemGrey.withOpacity(0.3)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('email', style: TextStyle(fontSize: 13),),
                      Text('$email', style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () async{
                  final Uri uri = await Uri.parse('mailto: $email ');
                  await launchUrl(uri);

                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: CupertinoColors.systemGrey.withOpacity(0.3)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('sms', style: TextStyle(fontSize: 13),),
                      Text('$phone', style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () async{
                  final Uri uri = await Uri.parse('$url');
                  await launchUrl(uri);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: CupertinoColors.systemGrey.withOpacity(0.3)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('url', style: TextStyle(fontSize: 13),),
                      Text('$url', style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 14),)
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
