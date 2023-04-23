import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/page1': (BuildContext context) => Page1(),
        '/page2': (BuildContext context) => Page2(),
        '/page3': (BuildContext context) => Page3(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/page4':
            return CupertinoPageRoute(
              builder: (BuildContext context) => Page4(),
            );
          default:
            return null;
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Page 1'),
              onPressed: () => Navigator.pushNamed(context, '/page1'),
            ),
            ElevatedButton(
              child: Text('Page 2'),
              onPressed: () => Navigator.pushNamed(context, '/page2'),
            ),
            ElevatedButton(
              child: Text('Page 3'),
              onPressed: () => Navigator.pushNamed(context, '/page3'),
            ),
            ElevatedButton(
              child: Text('Page 4'),
              onPressed: () => Navigator.pushNamed(context, '/page4'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: Center(
        child: Text('This is Page 1'),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('This is Page 2'),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
      ),
      body: Center(
        child: Text('This is Page 3'),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Page 4'),
      ),
      child: Center(
        child: Text('This is Page 4'),
      ),
    );
  }
}