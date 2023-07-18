import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  List<FAQItem> faqItems = [
    FAQItem(
      question:
          'What makes your cryptocurrency information hub suitable for beginners?',
      answer:
          'Discover the world of cryptocurrencies with ease! Our user-friendly hub is tailor-made for beginners. With a simple interface and clear explanations, young adults aged 18-29 can confidently explore and understand the basics of cryptocurrencies.',
    ),
    FAQItem(
      question: 'How reliable is the live market data on your platform?',
      answer:
          'We source our live market data from the Crypto Compare API, a reputable and widely used cryptocurrency data provider. By leveraging this API, we ensure that the market data presented on our platform is accurate, up-to-date, and reliable. ',
    ),
    FAQItem(
      question:
          'Can I convert cryptocurrency values to traditional currencies on your platform?',
      answer:
          'Our cryptocurrency information hub features a currency converter. With this tool, you can easily convert cryptocurrency values to traditional currencies, allowing you to understand the monetary implications of different cryptocurrencies.',
    ),
    FAQItem(
      question:
          'How frequently is your platform updated with new cryptocurrencies?',
      answer:
          'Our team actively monitors the cryptocurrency landscape and adds new cryptocurrencies as they emerge and gain prominence. We ensure that our users can access a comprehensive list of existing cryptocurrencies, enabling them to explore more options. ',
    ),
    FAQItem(
      question:
          'Can I access your cryptocurrency information hub on both a website and a mobile app?',
      answer:
          'Absolutely! We understand the importance of accessibility and convenience. Our cryptocurrency information hub is available as a website and a mobile app. The website is the primary platform, offering a comprehensive and immersive experience.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D0D2B),
        leading: IconButton(
          icon: const Icon(
            AkarIcons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xFFF9FAFD),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FAQ',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.robotoSlab(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Frequently Asked Questions',
                          style: GoogleFonts.robotoSlab(
                              color: const Color(0xFFBB0163)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ListView.builder(
                shrinkWrap: true,
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              faqItems[index].question,
                            ),
                          ),
                        ),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFFBB0163)),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  faqItems[index].answer,
                                  textAlign: TextAlign.justify,
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
