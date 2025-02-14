import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:match/add_to_match.dart';
import 'package:match/app_dialog.dart';
import 'package:match/models/user.dart';
import 'package:match/participant_controller.dart';
import 'package:match/search_bar_widget.dart';

class PlayerMatchPage extends StatelessWidget {
  PlayerMatchPage({super.key});

  final ParticipantController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    List<User> players =
        participants.where((user) => user.role == 'Player').toList();

    print(players.length);
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 36),
        padding: const EdgeInsets.all(8),
        child: AppDialogBox(
          boxHeight: screenHeight * 0.78,
          title: 'Players',
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SearchBarWidget(),

                Expanded(
                  // Use Flexible or Expanded
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return AddToMatch(user: players[index]);
                    },
                    itemCount: players.length,
                    padding: EdgeInsets.zero,
                  ),
                ),
                //const Spacer(),
                const Divider(),
                SizedBox(
                  height: screenHeight * .07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Obx(() {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.participatedUsers.length,
                            itemBuilder: (context, idx) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: _buildBottomImageBox(
                                    controller.participatedUsers[idx]),
                              );
                            },
                          );
                        }),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomImageBox(User user) {
    return Stack(
      children: [
        SvgPicture.asset('assets/profile.svg'),
        Positioned(
          top: 6,
          left: 50,
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
