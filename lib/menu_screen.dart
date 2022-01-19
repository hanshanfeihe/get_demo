import 'package:flutter/material.dart';
import 'package:get_demo/battery_level_screen.dart';
import 'package:get_demo/scroll_screen.dart';

/// @Author kang
/// @Date 2022/1/19 22:11
/// @Version 1.0
class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: ListView(
        children:  [
          ListTile(
            title: const Text('get device battery info'),
            onTap: (){
              Navigator.push(context,MaterialPageRoute (
                builder: (BuildContext context) => const BatteryLevelScreen(),
              ),);
            },
          ),
          ListTile(
            title: const Text('scroll demo'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ScrollScreen()));
            },
          )
        ],
      ),
    );
  }
}
