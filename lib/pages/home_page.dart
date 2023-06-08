import 'package:flutter/material.dart';
import 'package:flutter_rest_api/pages/account_page.dart';
import 'package:flutter_rest_api/pages/process_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; 
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _childeren = [
    const ProcessPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(backgroundColor: Colors.lightBlue,),
        body: _childeren[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.data_usage_sharp,
              ),
              label: 'İşlem Sayfası',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Hesap',
            ),
          ],
        ),
      ),
    );
  }
}