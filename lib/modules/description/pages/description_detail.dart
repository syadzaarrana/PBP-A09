import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {super.key,
      required this.title,
      required this.date,
      required this.image,
      required this.desc});

  final String title;
  final String date;
  final String image;
  final String desc;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
          title: const Text('Description Detail'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.date,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 25),
              Text(
                widget.desc,
                textAlign: TextAlign.justify,
              ),
              const Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45)),
                  onPressed: (() => Navigator.pop(context)),
                  child: const Text(
                    'Back',
                    style: TextStyle(fontSize: 14),
                  ))
            ],
          ),
        ));
  }
}
