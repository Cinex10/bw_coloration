import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mini_projet_mobile/app_constance.dart';

Future<void> getAlpha() async {
  // print('alp');
  // return;
  final response = await Dio().get(AppConstance.host);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.data);
  }
}

class Controller {
  Future<Map<String, String>?> uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    print('${AppConstance.host}/image');
    if (result != null) {
      try {
        Dio dio = Dio();
        dio.options.headers['content-type'] = 'multipart/form-data';
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(result.files[0].path!),
        });
        final res =
            await dio.post('${AppConstance.host}/image', data: formData);
        print('\n\n\n${res.data}\n\n\n');

        return {
          'original': res.data['original'],
          'colorized': res.data['colorized'],
        };
      } catch (e) {
        print('Error sending image to FastAPI backend: $e');
      }
    }
    return null;
  }

  Future<Map<String, String>?> uploadVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null) {
      try {
        Dio dio = Dio();
        dio.options.headers['content-type'] = 'multipart/form-data';
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(result.files[0].path!),
        });
        final res =
            await dio.post('${AppConstance.host}/video', data: formData);
        print('\n\n\n${res.data}\n\n\n');

        return {
          'original': res.data['original'],
          'colorized': res.data['colorized'],
        };
      } catch (e) {
        print('Error sending image to FastAPI backend: $e');
      }
    }
    return null;
  }

  Future<void> saveImage(String imgUrl, String imgName,
      void Function(int, int) onReceiveProgress) async {
    var dir = await getTemporaryDirectory();
    print(dir.path);
    await Dio().download(imgUrl, '${dir.path}/$imgName',
        onReceiveProgress: onReceiveProgress);
  }
}
