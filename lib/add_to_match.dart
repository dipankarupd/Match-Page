import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:match/individual_frame.dart';
import 'package:match/models/user.dart';
import 'package:match/names_field.dart';
import 'package:match/participant_controller.dart';

class AddToMatch extends StatelessWidget {
  final User user;
  const AddToMatch({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    final ParticipantController controller = Get.find();

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // PersonFrame(
              //   dp: user.dp,
              // ),
              const IndividualFrame(width: 60, height: 64, imageUrl: ''),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NameFields(
                      name: user.name,
                      id: user.userId,
                    ),
                    Obx(
                      () {
                        bool isAdded = controller.isAdded(user);

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: isAdded
                              ? ChangingButtons(
                                  title: 'REMOVE',
                                  buttonColor: const Color(0xffC7C7C7),
                                  titleColor: Colors.black,
                                  key: ValueKey('remove_${user.userId}'),
                                  onPress: () {
                                    controller.removeParticipant(user);
                                  },
                                )
                              : ChangingButtons(
                                  title: 'ADD',
                                  buttonColor: const Color(0xffde2234),
                                  titleColor: Colors.white,
                                  key: ValueKey('add_${user.userId}'),
                                  onPress: () {
                                    controller.addParticipant(user);
                                  },
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.0004,
          color: const Color(0xff707070),
        ),
      ],
    );
  }
}

class ChangingButtons extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color titleColor;
  final VoidCallback onPress;

  const ChangingButtons({
    super.key,
    // required this.text,
    // this.color = const Color(0xffde2234),
    required this.onPress,
    required this.title,
    required this.buttonColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        elevation: 1,
        shadowColor: Colors.red,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Container(
        width: 85,
        height: 40,
        //padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: const Color(0xffc5d1d8), width: 1.4),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
              color: buttonColor, //const Color(0xffde2234),
              border: Border.all(
                color: const Color(0xff090909),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            title,
            style: TextStyle(
                color: titleColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.84
                //fontFamily: 'Jost',
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class PersonFrame extends StatelessWidget {
  final String dp;
  const PersonFrame({super.key, required this.dp});

  @override
  Widget build(BuildContext context) {
    print(dp);
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenheight = MediaQuery.of(context).size.height;
    return SizedBox(
        width: screenWidth * 0.17,
        height: screenWidth * 0.17,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 4,
              bottom: -12,
              left: -4,
              right: 3,
              child: SvgPicture.asset(
                'assets/profile.svg',
                width: screenWidth * 0.17,
                height: screenWidth * 0.17,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.center,
                child: IndividualFrame(
                  width: screenWidth * 0.16,
                  height: screenWidth * 0.16,
                  imageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Elon_Musk_in_2023_%28cropped%29.jpg/440px-Elon_Musk_in_2023_%28cropped%29.jpg',
                ),
              ),
            ),
          ],
        ));
  }
}
