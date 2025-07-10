import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoundButton(onTap: () {}),
                  const DateSelector(),
                  RoundButton(onTap: () {}),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hello, Andrey',
                    style: context.theme.textTheme.displayLarge,
                  ),
                  Text(
                    'Have a nice day',
                    style: context.theme.textTheme.titleMedium!.copyWith(
                      color: context.colors.gray,
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Row(
                  children: [
                    const Expanded(child: CategoryTabBar()),
                    const SizedBox(width: 15),
                    RoundButton(onTap: () {}),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverList.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return TaskCard(
                  title: 'Task',
                  description: 'Task Task Task',
                  createdAt: DateTime.now(),
                  onCheckboxChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                );
              },
            ),
          ],
        ),
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
