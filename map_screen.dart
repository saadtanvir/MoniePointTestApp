import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        height = 100;
        width = 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/mapdarkmode.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          const Positioned(
            top: 70,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: Center(child: AnimatedSearchTextField()),
                ),
                // Spacer(),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: AnimatedFilterIcon(),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 130,
            left: 20,
            child: Column(
              children: [
                // menu button
                MenuButton(),
                SizedBox(height: 20),
                // chat button
                ChatButton(),
              ],
            ),
          ),
          const Positioned(
            bottom: 130,
            right: 20,
            child: VariantListButton(),
          ),
        ],
      ),
    );
  }
}

class AnimatedFilterIcon extends StatefulWidget {
  const AnimatedFilterIcon({super.key});

  @override
  State<AnimatedFilterIcon> createState() => _AnimatedFilterIconState();
}

class _AnimatedFilterIconState extends State<AnimatedFilterIcon> {
  bool isAnimationCompleted = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        isAnimationCompleted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: isAnimationCompleted ? 50 : 0,
      height: isAnimationCompleted ? 50 : 0,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.filter_alt,
        size: isAnimationCompleted ? 25 : 0,
      ),
    );
  }
}

class AnimatedSearchTextField extends StatefulWidget {
  const AnimatedSearchTextField({super.key});

  @override
  State<AnimatedSearchTextField> createState() =>
      _AnimatedSearchTextFieldState();
}

class _AnimatedSearchTextFieldState extends State<AnimatedSearchTextField> {
  TextEditingController searchController =
      TextEditingController(text: "Saint Petersburg");

  double searchFieldWidth = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        searchFieldWidth = 280;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      width: searchFieldWidth,
      transformAlignment: Alignment.center,
      alignment: Alignment.center,
      // curve: Curves.,
      child: TextField(
        controller: searchController,
        readOnly: true,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(Icons.search),
          contentPadding: EdgeInsets.zero,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

class VariantListButton extends StatefulWidget {
  const VariantListButton({super.key});

  @override
  State<VariantListButton> createState() => _VariantListButtonState();
}

class _VariantListButtonState extends State<VariantListButton> {
  bool isAnimationCompleted = false;
  Widget animatedChild = const SizedBox();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        isAnimationCompleted = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        animatedChild = const Row(
          children: [
            ListIconButton(),
            Text(
              "List of variants",
              style: TextStyle(
                color: Colors.white,
                // fontSize: isAnimationCompleted ? 14 : 0,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 50,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: isAnimationCompleted ? 170 : 0,
          height: isAnimationCompleted ? 50 : 0,
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(10),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            switchInCurve: Curves.easeInOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: animatedChild,
          ),
        ),
      ),
    );
  }
}

class ListIconButton extends StatelessWidget {
  const ListIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[400],
      ),
      child: const Icon(
        Icons.format_list_bulleted_outlined,
        color: Colors.white,
      ),
    );
  }
}

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool isAnimationCompleted = false;
  Widget animatedChild = const SizedBox();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        isAnimationCompleted = true;
        //////
        animatedChild = const Icon(
          Icons.menu,
          color: Colors.white,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          width: isAnimationCompleted ? 50 : 0,
          height: isAnimationCompleted ? 50 : 0,
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[400],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: animatedChild,
          ),
        ),
      ),
    );
  }
}

class ChatButton extends StatefulWidget {
  const ChatButton({super.key});

  @override
  State<ChatButton> createState() => _ChatButtonState();
}

class _ChatButtonState extends State<ChatButton> {
  bool isAnimationCompleted = false;
  Widget animatedChild = const SizedBox();
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        isAnimationCompleted = true;
        //////
        animatedChild = const Icon(
          Icons.chat,
          color: Colors.white,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          width: isAnimationCompleted ? 50 : 0,
          height: isAnimationCompleted ? 50 : 0,
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[400],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: animatedChild,
          ),
        ),
      ),
    );
  }
}
