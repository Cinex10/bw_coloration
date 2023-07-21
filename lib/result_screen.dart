import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mini_projet_mobile/app_constance.dart';
import 'package:mini_projet_mobile/controller.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.original,
    required this.colorized,
  });
  final String original;
  final String colorized;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _downloading = false;
  String _progressString = '';
  int rec = 0;
  int total = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          // style: TextStyle(
          //   fontFamily: 'GreatVibes',
          // ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  '${AppConstance.host}/files/${widget.original}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  '${AppConstance.host}/files/${widget.colorized}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            (!_downloading)
                ? const Spacer(
                    flex: 2,
                  )
                : Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: LinearProgressIndicator(
                            value: rec / total,
                            minHeight: 6.0,
                          ),
                        ),
                        Text("${((rec / total) * 100).toStringAsFixed(0)}%")
                      ],
                    ),
                  ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Controller().saveImage(
                      '${AppConstance.host}/files/bw_images (1).jpeg',
                      'bw_images (1).jpeg', (rec_, total_) {
                    setState(() {
                      print(rec / total);
                      _downloading = true;
                      _progressString =
                          "${((rec / total) * 100).toStringAsFixed(0)}%";

                      rec = rec_;
                      total = total_;
                      // if (rec == total){
                      //   _downloading
                      // }
                    });
                  });
                },
                icon: const Icon(Icons.save),
                label: const Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
