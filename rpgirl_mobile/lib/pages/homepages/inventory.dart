import 'package:flutter/material.dart';
import 'package:rpgirl2/widgets/spells.dart';
import 'package:rpgirl2/widgets/equipment.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('INVENTORY'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: "EQUIPMENT"),
              Tab(text: "SPELLS"),
              
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            EquipmentPage(),
            SpellsPage(),
          ],
        ),
      ),
    );
  }
}