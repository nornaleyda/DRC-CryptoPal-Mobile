import 'package:flutter/material.dart';

class NewsCardLoading extends StatelessWidget {
  const NewsCardLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
      ),
      child: Row(
        children: [
          const LoadingBar(
            height: 120,
            width: 120,
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LoadingBar(),
              SizedBox(height: 8),
              LoadingBar(),
              SizedBox(height: 8),
              LoadingBar(),
              SizedBox(height: 8),
              LoadingBar(
                width: 80,
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class MarketCardLoading extends StatelessWidget {
  const MarketCardLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 10.0,
        right: 10.0,
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: LoadingBar(
              height: 45,
              width: 45,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LoadingBar(
                width: 80,
              ),
              SizedBox(
                height: 8.0,
              ),
              LoadingBar(
                width: 50,
              ),
            ],
          )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              LoadingBar(
                width: 80,
              ),
              SizedBox(
                height: 8.0,
              ),
              LoadingBar(
                width: 50,
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    super.key,
    this.height,
    this.width,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(25.0))),
    );
  }
}
