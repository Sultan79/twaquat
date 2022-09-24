import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    String? url;

    try {
      print('99999999');
      await firebase_storage.FirebaseStorage.instance
          .ref('imageHolder/$fileName')
          .putFile(file)
          .then((p0) async => {
                url = await p0.ref.getDownloadURL(),
                print('Image has been uploaded')
              });
      ;
    } on firebase_core.FirebaseException catch (e) {
      print('e.message');
      print(e.message);
    }

    return url!;
  }

  Future<String> uploadFileGroup(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    String? url;

    try {
      print('Group Image has been saved');
      await firebase_storage.FirebaseStorage.instance
          .ref('imageGroup/$fileName')
          .putFile(file)
          .then((p0) async => url = await p0.ref.getDownloadURL());
    } on firebase_core.FirebaseException catch (e) {
      print('e.message');
      print(e.message);
    }

    return url!;
  }
}
