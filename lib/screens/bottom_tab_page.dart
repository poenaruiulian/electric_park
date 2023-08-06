import 'package:electric_park/constants/constants.dart';
import 'package:electric_park/screens/screens.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _index = 0;

  final screens = [const HomePage(), const ProfilPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[_index],
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(color: KColors.quatro
                // gradient: LinearGradient(
                //     colors: [KColors.quatro, KColors.secondary])
                ),
            child: BottomAppBar(
                elevation: 0,
                color: Colors.transparent,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconBottomBar(
                                text: "Home",
                                icon: Icons.map,
                                selected: _index == 0,
                                onPress: () {
                                  setState(() {
                                    _index = 0;
                                  });
                                }),
                            IconBottomBar(
                                text: "Profile",
                                icon: Icons.person,
                                selected: _index == 1,
                                onPress: () {
                                  setState(() {
                                    _index = 1;
                                  });
                                })
                          ],
                        ))))));
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPress})
      : super(key: key);

  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: onPress,
            icon: Icon(
              icon,
              size: 25,
              color: selected ? KColors.tertiary : KColors.background,
            )),
        Text(text,
            style: TextStyle(
                fontSize: 12,
                height: .1,
                color: selected ? KColors.tertiary : KColors.background))
      ],
    );
  }
}
