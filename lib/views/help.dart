import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  List<FAQItem> faqItems = [
    FAQItem(
      question: 'FAQ 1',
      answer: 'Answer 1',
    ),
    FAQItem(
      question: 'FAQ 2',
      answer: 'Answer 2',
    ),
    FAQItem(
      question: 'FAQ 3',
      answer: 'Answer 3',
    ),
    FAQItem(
      question: 'FAQ 4',
      answer: 'Answer 4',
    ),
    FAQItem(
      question: 'FAQ 5',
      answer: 'Answer 5',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D2B),
        centerTitle: true,
        title: const Text('Help'),
      ),
      backgroundColor: const Color(0xFFF9FAFD),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 12.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'FAQ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          'Frequently Asked Questions',
                          style: TextStyle(color: Colors.pink),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ListView.builder(
                shrinkWrap: true, // Set shrinkWrap to true
                itemCount: faqItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ExpansionTile(
                        iconColor: Colors.black,
                        textColor: Colors.black,
                        title: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: Text(
                            faqItems[index].question,
                          ),
                        ),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.pink),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  faqItems[index].answer,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}
