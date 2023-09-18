import 'package:flutter/material.dart';

class inicioapp extends StatefulWidget {
  const inicioapp({super.key});

  @override
  State<inicioapp> createState() => _inicioappState();
}

class _inicioappState extends State<inicioapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemExtent: 100,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.red,
                  child: FittedBox(
                    child: Text(
                      index.toString(),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Completas',
              style: Theme.of(context).textTheme.headline4,
            ),
            ListView.builder(
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemExtent: 100,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue,
                  child: FittedBox(
                    child: Text(
                      index.toString(),
                    ),
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
