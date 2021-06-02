import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEntrySuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(right: 32, left: 32, top: 64, bottom: 16),
            child: Center(
              child: Text(
                'Entry created successfully',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 32, left: 32, bottom: 48),
            child: Center(
              child: Text(
                'You have created a new entry.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 32, left: 32, bottom: 32),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Go back'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
