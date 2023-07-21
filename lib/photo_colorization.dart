import 'package:flutter/material.dart';
import 'package:mini_projet_mobile/controller.dart';
import 'package:mini_projet_mobile/result_screen.dart';

class PhotoColorization extends StatefulWidget {
  const PhotoColorization({super.key});

  @override
  State<PhotoColorization> createState() => _PhotoColorizationState();
}

class _PhotoColorizationState extends State<PhotoColorization> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Colorize your old images 🖌️🎨',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 23.0,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset('assets/images/bw2color.gif'),
            ),
            RichText(
              text: const TextSpan(
                  text: 'About\n',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                      ),
                    ),
                  ]),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await Controller().uploadImage().then((value) {
                    setState(() {
                      _isLoading = false;
                    });
                    if (value != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              colorized: value['colorized']!,
                              original: value['original']!,
                            ),
                          ));
                    }
                  });
                },
                icon: (!_isLoading)
                    ? const Icon(Icons.upload)
                    : const SizedBox(
                        height: 23,
                        width: 23,
                        child: CircularProgressIndicator(),
                      ),
                label: const Text(
                  'Upload an image',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   label: const Text(
      //     'Try',
      //     style: TextStyle(
      //       fontWeight: FontWeight.w700,
      //     ),
      //   ),
      //   icon: const Icon(Icons.add),
      // ),
    );
  }
}
