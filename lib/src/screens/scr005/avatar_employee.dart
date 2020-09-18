/*
 * File: avatar_employee.dart
 * Project: CVideo
 * File Created: Sunday, 5th July 2020 4:07:55 pm
 * Author: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Last Modified: Sunday, 5th July 2020 4:07:58 pm
 * Modified By: minhndse130706 (minhndse130706@fpt.edu.vn)
 * -----
 * Copyright (C) Daxua Team
 */
import 'dart:io';

import 'package:cvideo_mobile/src/app_components/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AvatarEmployee extends StatefulWidget {
  String image;
  AvatarEmployee({
    Key key,
    @required this.image,
  }) : super(key: key);
  @override
  _AvatarEmployeeState createState() => _AvatarEmployeeState();
}

class _AvatarEmployeeState extends State<AvatarEmployee> {
  File _selectedFile;
  bool _inProcess = false;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20.0), // CHANGE BORDER RADIUS HERE
              side: BorderSide(width: 1),
            ),
            title: Text("You wanna get your image from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.camera_alt,
                          size: 30.0,
                          color: AppColors.primaryDarkColor.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                            "Camera",
                            style: TextStyle(
                                color:
                                    AppColors.primaryDarkColor.withOpacity(0.5),
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.camera_alt,
                          size: 30.0,
                          color: AppColors.primaryDarkColor.withOpacity(0.5),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                            "Gallery",
                            style: TextStyle(
                                color:
                                    AppColors.primaryDarkColor.withOpacity(0.5),
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      this.setState(() {
        _selectedFile = image;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return CircleAvatar(
        radius: 65,
        backgroundImage: FileImage(_selectedFile),
      );
    } else {
      return CircleAvatar(
        radius: 65,
        backgroundImage: widget.image.isEmpty
            ? AssetImage("assets/screens/scr002/user.png")
            : NetworkImage(widget.image),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: getImageWidget(),
      ),
      onTap: () {
        _showChoiceDialog(context);
      },
    );
  }
}
