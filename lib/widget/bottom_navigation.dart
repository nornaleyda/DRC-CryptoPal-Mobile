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
                color: const Color(0xFF979797).withOpacity(0.5),
                width: 2.0,
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
                      color:
                          index == 0 ? const Color(0xFFBB0163) : const Color(0xFF979797)),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.newspaper,
                    size: 25,
                    color: index == 1 ? const Color(0xFFBB0163) : const Color(0xFF979797)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart,
                    size: 25,
                    color: index == 2 ? const Color(0xFFBB0163) : const Color(0xFF979797)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star,
                    size: 25,
                    color: index == 3 ? const Color(0xFFBB0163) : const Color(0xFF979797)),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity,
                    size: 25,
                    color: index == 4 ? const Color(0xFFBB0163) : const Color(0xFF979797)),
                label: '',
              ),
            ],
            currentIndex: index,
            selectedItemColor: const Color(0xFFBB0163),
            unselectedItemColor: const Color(0xFF979797),
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
