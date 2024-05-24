import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final double leftSpacing = 20.0;
  bool isAvatarAnimationCompleted = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        isAvatarAnimationCompleted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        // height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.orange[200]!,
            Colors.orange[50]!,
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        )),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _LocationTile(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      height: isAvatarAnimationCompleted ? 50 : 0,
                      width: isAvatarAnimationCompleted ? 50 : 0,
                      child: const _CircularAvatar(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const SizedBox(
                height: 100,
                child: Column(
                  children: [
                    AnimatedGreetingText(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: AnimatedMessageText(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOfferCounted(),
                  SizedBox(
                    width: 10,
                  ),
                  AnimatedRentWidget(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const AnimatedPropertyCardGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedPropertyCardGridView extends StatefulWidget {
  const AnimatedPropertyCardGridView({super.key});

  @override
  State<AnimatedPropertyCardGridView> createState() =>
      _AnimatedPropertyCardGridViewState();
}

class _AnimatedPropertyCardGridViewState
    extends State<AnimatedPropertyCardGridView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> offset;

  List<String> propertyCardList = [
    "assets/images/home1.jpeg",
    "assets/images/home2.jpeg",
    "assets/images/home3.jpeg",
    "assets/images/home4.jpeg",
    "assets/images/home5.jpeg",
    "assets/images/home6.jpeg",
    "assets/images/home1.jpeg",
    "assets/images/home3.jpeg",
    "assets/images/home2.jpeg",
    // "assets/images/home6.jpeg",
  ];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: propertyCardList.mapIndexed((index, asset) {
              (int mainAxisCount, int crossAxisCount) axisCount = index % 4 == 0
                  ? (1, 2)
                  : index % 4 == 1
                      ? (2, 1)
                      : (1, 1);
              return StaggeredGridTile.count(
                crossAxisCellCount: axisCount.$2,
                mainAxisCellCount: axisCount.$1,
                child: PropertyCard(
                  assetName: asset,
                ),
              );
            }).toList()),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final String assetName;
  const PropertyCard({required this.assetName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(
            assetName,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class AnimatedRentWidget extends StatefulWidget {
  const AnimatedRentWidget({super.key});

  @override
  State<AnimatedRentWidget> createState() => _AnimatedRentWidgetState();
}

class _AnimatedRentWidgetState extends State<AnimatedRentWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Center(
        child: TweenAnimationBuilder(
            tween: SizeTween(
                begin: const Size(0.0, 0.0), end: const Size(180.0, 180.0)),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              if (value == null) return const SizedBox();
              return Container(
                width: value.width,
                height: value.height,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'RENT',
                        style: TextStyle(
                          color: Colors.brown[200],
                          fontSize: 20,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: AnimateIncrementedNumbers(
                          begin: 0,
                          end: 2212,
                          style: TextStyle(
                            color: Colors.brown[400],
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'offers',
                        style: TextStyle(
                          color: Colors.brown[400],
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class AnimateIncrementedNumbers extends StatelessWidget {
  final int begin;
  final int end;
  final TextStyle? style;
  const AnimateIncrementedNumbers(
      {required this.begin, required this.end, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: IntTween(begin: begin, end: end),
        duration: const Duration(seconds: 1),
        builder: (context, value, child) {
          return Text('$value', style: style);
        });
  }
}

class AnimatedOfferCounted extends StatefulWidget {
  const AnimatedOfferCounted({super.key});

  @override
  State<AnimatedOfferCounted> createState() => _AnimatedOfferCountedState();
}

class _AnimatedOfferCountedState extends State<AnimatedOfferCounted> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Center(
        child: TweenAnimationBuilder(
          tween: SizeTween(
              begin: const Size(0.0, 0.0), end: const Size(180.0, 180.0)),
          duration: const Duration(seconds: 1),
          builder: (context, value, child) {
            return Container(
              width: value?.width,
              height: value?.height,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'BUY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: const SizedBox(
                  //     height: 10,
                  //   ),
                  // ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimateIncrementedNumbers(
                        begin: 0,
                        end: 1034,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'offers',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class AnimatedMessageText extends StatefulWidget {
  const AnimatedMessageText({super.key});

  @override
  State<AnimatedMessageText> createState() => _AnimatedMessageTextState();
}

class _AnimatedMessageTextState extends State<AnimatedMessageText>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: const Text(
        "let's select your\nperfect place",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AnimatedGreetingText extends StatefulWidget {
  const AnimatedGreetingText({super.key});

  @override
  State<AnimatedGreetingText> createState() => _AnimatedGreetingTextState();
}

class _AnimatedGreetingTextState extends State<AnimatedGreetingText> {
  bool isFullyVisible = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        isFullyVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: AnimatedOpacity(
          opacity: isFullyVisible ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Text(
            'Hi, Marina',
            style: TextStyle(
              fontSize: 20,
              color: Colors.brown[200],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _CircularAvatar extends StatelessWidget {
  const _CircularAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/girly-dp.jpg",
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: child,
        );
      },
    );
  }
}

class _LocationTile extends StatefulWidget {
  const _LocationTile({super.key});

  @override
  State<_LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<_LocationTile>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> offset;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    offset = Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.brown[200],
            ),
            const SizedBox(width: 5),
            Text(
              'Saint Petersburg',
              style: TextStyle(
                color: Colors.brown[200],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
