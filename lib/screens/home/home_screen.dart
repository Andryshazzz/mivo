import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: const Text('sad'),
            backgroundColor: context.colors.noirVioletLight,
            surfaceTintColor: Colors.transparent,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: context.colors.grayDark),
                    child: const Center(child: Text('Task card')),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverList.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: context.colors.grayDark),
                child: const Center(child: Text('Task card')),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'adsd'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'adsd'),
          BottomNavigationBarItem(icon: Icon(Icons.link), label: 'adsd'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'adsd'),
        ],
      ),
    );
  }
}
