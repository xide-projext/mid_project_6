import 'package:flutter/material.dart';

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel App'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Text('Reserve'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyReservationsPage()),
                );
              },
              child: Text('My Reservations'),
            ),
            SizedBox(height: 16),
            Text(
              'Recommendations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Container(
              height: 395,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/building${index + 1}.jpg',
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Image Description'),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FourthPage(title: 'Reservation')),
                          );
                        },
                        child: Text('Reserve'),
                      ),
                    ],
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

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String? _selectedType;
  bool _dateFilled = false;
  int _peopleCount = 0;
  List<String> buttonNames = [
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 4',
    'Button 5',
    'Button 6',
  ];

  @override
  Widget build(BuildContext context) {
    // ... rest of the code
    bool _enableGridButtons = _selectedType != null && _dateFilled && _peopleCount > 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Booking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedType = 'Hotel';
                    });
                  },
                  child: Text('Hotel'),
                  style: ElevatedButton.styleFrom(
                    primary: _selectedType == 'Hotel' ? Colors.blue : Colors.grey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedType = 'Activities';
                    });
                  },
                  child: Text('Activities'),
                  style: ElevatedButton.styleFrom(
                    primary: _selectedType == 'Activities' ? Colors.blue : Colors.grey,
                  ),
                ),
              ],
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _dateFilled = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(hintText: 'Date'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Number of people:'),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_peopleCount > 0) _peopleCount--;
                    });
                  },
                ),
                Text('$_peopleCount'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _peopleCount++;
                    });
                  },
                ),
              ],
            ),
    Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(buttonNames.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _enableGridButtons
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThirdPage(buttonName: buttonNames[index])),
                      );
                    }
                  : null,
              child: Text(buttonNames[index]),
              style: ElevatedButton.styleFrom(
                primary: _enableGridButtons ? Colors.blue : Colors.grey,
              ),
            ),
          );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem {
  final String imagePath;
  final List<String> textFields;

  ListItem({required this.imagePath, required this.textFields});
}

class ThirdPage extends StatelessWidget {
  final String buttonName;

  ThirdPage({required this.buttonName});

  final List<ListItem> items = [
    ListItem(
      imagePath: 'assets/cat.jpg',
      textFields: [
        'Text Field 1.1',
        'Text Field 1.2',
        'Text Field 1.3',
        'Text Field 1.4',
      ],
    ),
    ListItem(
      imagePath: 'assets/cat1.png',
      textFields: [
        'Text Field 2.1',
        'Text Field 2.2',
        'Text Field 2.3',
        'Text Field 2.4',
      ],
    ),
    ListItem(
      imagePath: 'assets/meme.jpg',
      textFields: [
        'Text Field 3.1',
        'Text Field 3.2',
        'Text Field 3.3',
        'Text Field 3.4',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(buttonName),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FourthPage(title: item.textFields.first),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      item.imagePath,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  for (String textField in item.textFields) ...[
                    Text(textField),
                    SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  final String title;

  FourthPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/building${index + 1}.jpg',
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'This is a sample description. Replace this with your desired text.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Text Field 1', style: TextStyle(fontSize: 16)),
                  Text('Text Field 2', style: TextStyle(fontSize: 16)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}

class MyReservationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reservations'),
      ),
      body: Center(
        child: Text('My Reservations Page'),
      ),
    );
  }
}
