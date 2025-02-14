import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:match/add_to_match.dart';
import 'package:match/app_dialog.dart';
import 'package:match/models/user.dart';
import 'package:match/participant_controller.dart';
import 'package:match/search_bar_widget.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final ParticipantController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Trigger rebuild when the tab index changes
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    List<User> organizers =
        participants.where((user) => user.role == 'Organizer').toList();
    List<User> sponsors =
        participants.where((user) => user.role == 'Sponsor').toList();
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.only(top: 36),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          child: AppDialogBox(
            title: 'ADD MEMBER',
            boxHeight: screenHeight * 0.765,
            isButton: true,
            onTab: () {
              // controller.confirmSelections();
              // Get.back();
            },
            buttonTitle: 'CANCEL',
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelPadding: const EdgeInsets.only(left: 0, right: 30),
                    indicator: CustomTabIndicator(),
                    // dividerColor: Colors.transparent,
                    tabs: [
                      _buildTabLabel('Organizer', organizers.length, 0),
                      _buildTabLabel('Sponsor', sponsors.length, 1),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const SearchBarWidget(),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: screenHeight * 0.45,
                    child: Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildUserList(organizers),
                          _buildUserList(sponsors),
                        ],
                      ),
                    ),
                  ),
                  //const Spacer(),
                  const Divider(),
                  Container(
                    alignment: Alignment.center,
                    // color: Colors.red,
                    child: SizedBox(
                      height: screenHeight * .07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // color: Colors.amber,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Center(
                              child: Obx(() {
                                return Padding(
                                  padding: EdgeInsets.only(top: 6),
                                  child: ListView.builder(
                                    scrollDirection: Axis
                                        .horizontal, // Make the list scroll horizontally
                                    itemCount:
                                        controller.participatedUsers.length,
                                    itemBuilder: (context, idx) {
                                      return Padding(
                                        padding: EdgeInsets
                                            .zero, // Add spacing between items
                                        child: _buildBottomImageBox(
                                            controller.participatedUsers[idx]),
                                      );
                                    },
                                  ),
                                );
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Obx(() {
                              return Text(
                                '+${controller.participatedUsers.length}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xffDEDEDE),
                                  letterSpacing: 1.26,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildTabLabel(String title, int count, int index) {
    bool isActive = _tabController.index == index; // Track active tab
    double size =
        isActive ? 26 : 18; // Adjust size based on active/inactive state

    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isActive ? 16 : 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              letterSpacing: isActive ? .36 : 1.4,
              color: isActive ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(width: 6),
          ClipPath(
            clipper: CheckboxClipper(),
            child: Container(
              padding: isActive
                  ? const EdgeInsets.only(
                      left: 6,
                      right: 6,
                      bottom: 7,
                      top: 3,
                    )
                  : const EdgeInsets.only(
                      left: 4,
                      right: 4,
                      bottom: 5,
                      top: 2,
                    ),
              decoration: BoxDecoration(
                color: Color(0xffC80D31),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                count.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: isActive ? 13 : 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, idx) {
        return AddToMatch(user: users[idx]);
      },
    );
  }

  Widget _buildBottomImageBox(User user) {
    return Stack(
      children: [
        SvgPicture.asset('assets/profile.svg'),
        Positioned(
          top: 4,
          left: 45,
          child: InkWell(
            onTap: () {
              controller.removeParticipant(user);
            },
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
                gradient: LinearGradient(
                  colors: [
                    Color(0xffDE2234),
                    Color(0xffBB0130),
                  ],
                ),
              ),
              child: const Icon(
                Icons.close,
                size: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CustomPainter();
  }
}

class CustomPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final double width = configuration.size!.width + 15;

    final double shiftLeft = -10; // Move indicator 10 pixels to the left

    final double height = 4; // Reduced height for a sleek look

    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.red.shade700, Colors.red.shade400],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(offset.dx, offset.dy, width, height))
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(offset.dx + shiftLeft, offset.dy + configuration.size!.height)
      ..lineTo(
          offset.dx + width + shiftLeft, offset.dy + configuration.size!.height)
      ..lineTo(offset.dx + width - 6 + shiftLeft,
          offset.dy + configuration.size!.height - height)
      ..lineTo(offset.dx + 5 + shiftLeft,
          offset.dy + configuration.size!.height - height)
      ..close();

    canvas.drawPath(path, paint);
  }
}

/// check box clipper
class CheckboxClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
