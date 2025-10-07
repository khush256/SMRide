import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Absolute™',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50.0),
          Center(
            child:
                profile('Khush Patel', 'assets/khush.jpg', 'Computer Science'),
          ),
        ],
      ),
    );
  }
}

Widget profile(name, image, dept) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage("assets/khush.jpg"), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(200)),
          // boxShadow: [BoxShadow(blurRadius: 9.0, color: Colors.black)]),
        ),
      ),
      Container(
        child: ListTile(
          title: Center(child: Text(name)),
          subtitle: Center(child: Text(dept)),
        ),
      )
    ],
  );
}
