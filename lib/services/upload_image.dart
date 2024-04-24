
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
final FirebaseStorage _storage = FirebaseStorage.instance;

class UploadImage{
  static Future<List<String>> uploadToStorage(List<Uint8List> files) async{
    List<String> urlImages = [];
    Reference ref =  _storage.ref().child('car-images');

    for(var file in files){
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference  fileRef = ref.child(uniqueFileName);
      UploadTask uploadTask = fileRef.putData(file);

      await uploadTask;

      String downloadUrl = await fileRef.getDownloadURL();
      urlImages.add(downloadUrl);
    }

    return urlImages;
  }
}