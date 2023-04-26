import 'package:flutter/material.dart';

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Korea',
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
        title: Text('Travel Korea'),
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
                      Text('Buildings'),
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
    'Seoul',
    'Busan',
    'Daegu',
    'Gyeonggi',
    'Incheon',
    'Jeju',
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
              decoration: InputDecoration(hintText: 'Month(MM)'),
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
      imagePath: 'assets/63building1.jpg',
      textFields: [
        '63 Building',
        'Yeongdeungpo-gu',
        'May 4th',
        '15,000krw',
      ],
    ),
    ListItem(
      imagePath: 'assets/seoulsky.jpg',
      textFields: [
        'Seoul Sky Bridge',
        'Songpa-gu',
        'May 1st',
        '96,000krw',
      ],
    ),
    ListItem(
      imagePath: 'assets/tower.jpg',
      textFields: [
        'Namsan Tower',
        'Yongsan-gu',
        'April 29th',
        '16,000krw',
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
                      'assets/63building${index + 1}.jpg',
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
              '63 Building',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '63 building is one of the tallest towers in Korea. It iconically glows gold especially when the sun shines on it. 63 Building offers a vast array of activities such as aquariums, sky views, and fancy restaurants and buffets. The relatively low price and the ability to see some of the greatest views in Korea is one of the main reasons to visit 63 Building. When you are done enjoying the view, even zooming in with the binoculars mounted outside, you can enjoy even grander views by visiting the aquarium where you can enjoy the aquatic life. To end the day, you can treat yourself to a great meal in one of the many restaurants that exist in 63 Building.',
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
                  Text('May 4th', style: TextStyle(fontSize: 16)),
                  Text('15,000krw', style: TextStyle(fontSize: 16)),
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
        child: Text('Payment options'),
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
        child: Text('Reservation History'),
      ),
    );
  }
}