import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';

const String apiKey =
    "8e97dbc8ca646305156112dcb5c5b49d0a8efd9745e749aa1bf35711fa5dc4c3";

class Chart extends StatefulWidget {
  final String cryptocurrencyName;
  final String currency;

  const Chart(
      {Key? key, required this.cryptocurrencyName, required this.currency})
      : super(key: key);

  @override
  State<Chart> createState() => ChartState();
}

class ChartState extends State<Chart> {
  late final IOWebSocketChannel channel;
  List<DataPoint> chartData = [];
  bool isSubscribed = false;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
      'wss://streamer.cryptocompare.com/v2?api_key=$apiKey',
    );
    subscribeToStream();
  }

  void toggleSubscription() {
    if (isSubscribed) {
      unsubscribeToStream();
    } else {
      subscribeToStream();
    }
  }

  void subscribeToStream() {
    final subRequest = {
      "action": "SubAdd",
      "subs": ["2~Coinbase~${widget.cryptocurrencyName}~${widget.currency}"]
    };
    final subRequestJson = jsonEncode(subRequest);
    channel.sink.add(subRequestJson);
    isSubscribed = true;
  }

  void unsubscribeToStream() {
    final subRequest = {
      "action": "SubRemove",
      "subs": ["2~Coinbase~${widget.cryptocurrencyName}~${widget.currency}"]
    };
    final subRequestJson = jsonEncode(subRequest);
    channel.sink.add(subRequestJson);
    isSubscribed = false;
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void updateChartData(num price, int lastUpdate) {
    if (chartData.length >= 20) {
      chartData.removeAt(0);
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(lastUpdate * 1000);
    String formattedDate = DateFormat('HH:mm:ss').format(dateTime);
    chartData.add(DataPoint(formattedDate, price.toDouble()));
    print('Price: $price');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 4,
        child: Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final message = snapshot.data;
                final decodedMessage = jsonDecode(message.toString());
                final messageType = decodedMessage['TYPE'];
                final currency = decodedMessage['TOSYMBOL'];

                print("Received from Cryptocompare: $currency");

                if (messageType == '2') {
                  decodedMessage.forEach((key, value) {
                    if (key == 'PRICE') {
                      num price = decodedMessage['PRICE'];
                      int lastUpdate = decodedMessage['LASTUPDATE'];
                      updateChartData(price, lastUpdate);
                    }
                  });
                }
              }

              return SfCartesianChart(
                zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  enableDoubleTapZooming: true,
                  enablePanning: true,
                ),
                primaryXAxis: CategoryAxis(
                  labelPlacement: LabelPlacement.onTicks,
                  labelRotation: 45,
                ),
                primaryYAxis: NumericAxis(
                  anchorRangeToVisiblePoints: false,
                  numberFormat: NumberFormat('#.5'),
                  labelAlignment: LabelAlignment.start,
                ),
                series: <LineSeries<DataPoint, String>>[
                  LineSeries<DataPoint, String>(
                    dataSource: chartData,
                    xValueMapper: (DataPoint data, _) => data.x,
                    yValueMapper: (DataPoint data, _) => data.y,
                    markerSettings: const MarkerSettings(isVisible: true),
                    color: const Color(0xFFA155B9),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class DataPoint {
  final String x;
  final double y;

  DataPoint(this.x, this.y);
}
