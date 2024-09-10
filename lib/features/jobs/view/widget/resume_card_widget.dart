import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/features/jobs/view/screens/edit_resume_view.dart';
import 'package:myapp/features/user/controller/user_controller.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';
import 'package:myapp/utils/loader/simmer_text.dart';

class ResumeCardWidget extends StatelessWidget {
  const ResumeCardWidget({
    super.key,
    this.navigateTo,
    this.displaySkills = false,
  });

  final Widget? navigateTo;
  final bool displaySkills;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: GestureDetector(
          onDoubleTap:
              navigateTo != null ? () => context.push(navigateTo!) : null,
          child: Container(
            decoration: const BoxDecoration(
                color: Constant.backgroundColorYellow,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            // height: double.maxFinite,
            // width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Consumer(
                builder: (context, ref, child) {
                  final userDetails =
                      ref.watch(userProfileBackendFutureProvider);
                  return userDetails.when(
                    data: (data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HeaderWidget(
                                data['full_name'],
                                color: Constant.backgroundColorDark,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () {
                                  context.push(
                                    const EditResumeView(),
                                  );
                                },
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                          const ResumeCardSubHeaderWidget(
                            text: "Junior marketing manager",
                          ),

                          //* Experience
                          SpacerConstant.sizedBox24,
                          Text(
                            "1 year of Experience".toUpperCase(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),

                          // * Body
                          SpacerConstant.sizedBox24,
                          Text(
                            "As a Junior Marketing Manager, I actively engaged in the end-to-end process of developing and implementing marketing strategies that were meticulously designed to achieve measurable results. My contributions spanned multiple aspects of marketing, from ideation and planning to execution and performance evaluation. Strategic Planning and Execution: In my role, I was deeply involved in the strategic planning process. I collaborated closely with senior management to define marketing objectives that aligned with the company’s broader business goals.",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),

                          // * Skills
                          displaySkills
                              ? Column(
                                  children: [
                                    SpacerConstant.sizedBox24,
                                    const ResumeCardSubHeaderWidget(
                                      text: "SKILLS DEVELOPED",
                                    ),
                                    SpacerConstant.sizedBox24,
                                    Text(
                                      "Strategic thinking, Team Collaboration, Project Management",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),

                                    //* Key achievements
                                    SpacerConstant.sizedBox24,
                                    const ResumeCardSubHeaderWidget(
                                      text: "KEY ACHIEVEMENTS",
                                    ),

                                    SpacerConstant.sizedBox24,
                                    Text(
                                      "I was instrumental in the successful launch of a new product line that resulted in a 20% increase in revenue within the first quarter of its introduction. I also spearheaded a social media campaign that increased brand awareness by 30% and generated a 15% increase in customer engagement.",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      );
                    },
                    loading: () {
                      return const ShimmerText(
                        "Loading...",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      );
                    },
                    error: (_, __) {
                      return const Text(
                        "Error fetching user data",
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResumeCardSubHeaderWidget extends StatelessWidget {
  const ResumeCardSubHeaderWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
