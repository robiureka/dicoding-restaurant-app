import 'package:flutter/material.dart';

class NoInterent extends StatelessWidget {
  static final routeName = '/no_internet';
  const NoInterent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/noun_no_signal.png"))),
          ),
          SizedBox(height: 19.0,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Whoopss, You are not connected to the Internet, Please turn on your mobile data or WiFi", textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
}
