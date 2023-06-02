
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:io';



class MainProvider extends ChangeNotifier{
  FirebaseFirestore db = FirebaseFirestore.instance;
  Reference ref = FirebaseStorage.instance.ref("Images");

  TextEditingController regNameCT = TextEditingController();
  TextEditingController regEmailCT = TextEditingController();
  TextEditingController regPhoneCT = TextEditingController();
  TextEditingController regDobCT = TextEditingController();

  String name='';
  String image='';
  String phone='';

  final ImagePicker picker = ImagePicker();
  File? fileimage;
  DateTime _date =  DateTime.now();
  DateTime scheduledTime =  DateTime.now();

  chooseImage(BuildContext context) async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    } else {
      print('No image selected.');
    }
    if (pickedFile!.path.isEmpty) retrieveLostData();
    notifyListeners();
  }


  Future<void> _cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      fileimage = File(croppedFile.path);
      print('${fileimage!.lengthSync()} bytes');
      notifyListeners();
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileimage = File(response.file!.path);

      notifyListeners();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate:  DateTime(2100),
    );

    if (picked != null) {
      _date = picked;
      scheduledTime =  DateTime(_date.year, _date.month, _date.day,);
      regDobCT.text=DateFormat('dd-MMM-yy').format(scheduledTime);;
      notifyListeners();
    }
  }

  Future<void> insertDataFun() async {
    Map<String,Object> map= HashMap();
    map['Name']=regNameCT.text;
    map['Email']=regEmailCT.text;
    map['DOB']=scheduledTime;
    map['Phone']=regPhoneCT.text;

    if (fileimage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref().child(time);
        await ref.putFile(fileimage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          if (value != "" || value != null){
            map['Image'] = value;
          }
        });
      });
    }
   await db.collection('UserDetails').doc(regPhoneCT.text).set(map);
    fetchDeatls(regPhoneCT.text);

  }
  
  Future<void> fetchDeatls(String mobile) async {
  await  db.collection('UserDetails').doc(mobile).get().then((value){
      if(value.exists){
        Map<dynamic,dynamic> map = value.data() as Map;
        name=map['Name']??"";
        image=map['Image']??"";
        phone=map['Phone']??"";
        notifyListeners();
      }
    });
  }

}