import 'package:flutter/material.dart';
import 'package:medico_app/utils/const_color.dart';
import 'package:medico_app/utils/transition.dart';
import 'package:medico_app/views/auth/login_screen.dart';
import 'package:medico_app/views/historyKesehatan/history.dart';
import 'package:medico_app/views/reservastion/create_screen.dart';
import 'package:medico_app/views/reservastion/index_screen.dart';
import 'package:medico_app/views/user/main_screen.dart';
import 'package:medico_app/views/user/profile_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key, this.selectedPage}) : super(key: key);
  final int? selectedPage;
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (!mounted) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  getPage(int page) {
    switch (page) {
      case 0:
        return MainScreen();
      case 1:
        return ProfileScreen();

      default:
        Navigator.pushAndRemoveUntil(
            context, generateSlideTransition(LoginScreen()), (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.selectedPage != null) {
      setState(() {
        _selectedIndex = widget.selectedPage!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: Offset(0, 5))
              ],
            ),
            child: BottomNavigationBar(
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.black,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Beranda",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profil",
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              selectedFontSize: 12,
              showUnselectedLabels: true,
              elevation: 0,
            ),
          ),
          body: Container(
            child: getPage(_selectedIndex),
          ),
        ),
      ),
    );
  }
}
