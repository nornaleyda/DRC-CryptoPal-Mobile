import 'package:flutter/material.dart';

class NewsCardLoading extends StatelessWidget {
  const NewsCardLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          const LoadingBar(
            height: 80,
            width: 80,
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            LoadingBar(
                              height: 45,
                              width: 45,
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 2,
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
                        flex: 1,
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
              )
            ],
          ),
        )
      ],
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
