import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';



import './screens.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  final int defaultSelectedIndex;



  const MainScreen({Key? key, this.defaultSelectedIndex = 2}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState(defaultSelectedIndex);
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex;

  _MainScreenState(this._selectedIndex);

  bool notification = false;



  static final List<Widget> _page = <Widget>[
    const PatientGeneralInformationScreen(),
    const AppointmentCardConfirmedScreen(),
    const HomeScreen(),
    const CustomerDetailScreen(),
    const ProfileOverviewScreen(),
  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _page[_selectedIndex],
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
          index: widget.defaultSelectedIndex,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          buttonBackgroundColor: Colors.purple,
          backgroundColor: Colors.transparent,
          height: 60,
          color: const Color.fromARGB(255, 220, 220, 220),
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            Icon(
              Icons.people,
              color: _selectedIndex == 0 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.calendar_month,
              color: _selectedIndex == 1 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.home,
              color: _selectedIndex == 2 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.account_circle_outlined,
              color: _selectedIndex == 3 ? Colors.white : Colors.black,
            ),

            Icon(
              Icons.account_balance_outlined,
              color: _selectedIndex == 4 ? Colors.white : Colors.black,
            ),
          ]),
    );
  }



}