import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/bottom_navigation_cubit.dart.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarCubit, int>(
      builder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                width: 5.0,
              ),
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                width: 5.0,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Center(
                  child: Icon(Icons.house,
                      size: 25,
                      color: index == 0 ? Colors.purple : Colors.grey),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper,
                    size: 25, color: index == 1 ? Colors.purple : Colors.grey),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart,
                    size: 25, color: index == 2 ? Colors.purple : Colors.grey),
                label: 'Markets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star,
                    size: 25, color: index == 3 ? Colors.purple : Colors.grey),
                label: 'Account',
              ),
            ],
            currentIndex: index,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey,
            onTap: (int tappedIndex) {
              context
                  .read<BottomNavigationBarCubit>()
                  .updateIndex(tappedIndex, context);
            },
          ),
        );
      },
    );
  }
}
