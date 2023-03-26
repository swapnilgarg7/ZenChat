import 'package:flutter/material.dart';

class DocsScreen extends StatefulWidget {
  const DocsScreen({super.key});

  @override
  State<DocsScreen> createState() => _DocsScreenState();
}

class _DocsScreenState extends State<DocsScreen> {
  int _docsCount = 7;

  final List _docImages = [
    'assets/docs/doc1.jpeg',
    'assets/docs/doc2.jpeg',
    'assets/docs/doc3.jpeg',
    'assets/docs/doc4.jpeg',
    'assets/docs/doc5.jpeg',
    'assets/docs/doc6.jpeg',
    'assets/docs/doc7.jpeg',
  ];

  final _docData = {
    'doc1': {
      'name': 'Dr. Harish Kumar',
      'fee': '1000',
      'time': '4PM-6PM',
    },
    'doc2': {
      'name': 'Dr. John Davis',
      'fee': '1500',
      'time': '2PM-8PM',
    },
    'doc3': {
      'name': 'Dr. Michael Lee',
      'fee': '1200',
      'time': '10AM-12PM',
    },
    'doc4': {
      'name': 'Dr. Robert Smith',
      'fee': '2000',
      'time': '7PM-10PM',
    },
    'doc5': {
      'name': 'Dr. Paul Johnson',
      'fee': '1800',
      'time': '1PM-4PM',
    },
    'doc6': {
      'name': 'Dr. Linda Williams',
      'fee': '1500',
      'time': '9AM-11AM',
    },
    'doc7': {
      'name': 'Dr. Peter Brown',
      'fee': '1200',
      'time': '9PM-11PM',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Doctors",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView.builder(
              itemCount: _docsCount,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  height: 144,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 120,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            _docImages[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _docData['doc${index + 1}']!['name'] ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Fee: \₹${_docData['doc${index + 1}']!['fee']} per hour',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Available Time: ${_docData['doc${index + 1}']!['time']}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
