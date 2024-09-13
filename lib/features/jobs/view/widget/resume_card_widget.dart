import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/features/jobs/controller/resume_controller.dart';
import 'package:myapp/features/jobs/view/screens/edit_resume_view.dart';
import 'package:myapp/features/user/controller/user_controller.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';
import 'package:myapp/utils/loader/simmer_text.dart';
import 'package:myapp/utils/shared/error_view.dart';

class ResumeCardWidget extends ConsumerWidget {
  const ResumeCardWidget({
    super.key,
    this.navigateTo,
    this.displaySkills = false,
  });

  final Widget? navigateTo;
  final bool displaySkills;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumeDetails = ref.watch(getResumeFutureProvider);
    return resumeDetails.when(data: (resumeData) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverToBoxAdapter(
          child: GestureDetector(
            behavior: HitTestBehavior
                .translucent, // Ensures IconButton can detect taps
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
                        return resumeData == null
                            ? Center(
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("No resume data found"),
                                  SpacerConstant.sizedBox20,
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      context.push(const EditResumeView());
                                    },
                                    label: const Text("Create Resume"),
                                    icon: const Icon(Icons.edit_outlined),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Constant.backgroundColorDark,
                                      foregroundColor:
                                          Constant.backgroundColorYellow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  )
                                ],
                              ))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //* Name and edit button
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                  ResumeCardSubHeaderWidget(
                                    text: resumeData.role,
                                  ),

                                  //* Experience
                                  SpacerConstant.sizedBox24,
                                  Text(
                                    "${resumeData.yearsOfExperience} year of Experience"
                                        .toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),

                                  // * Body
                                  SpacerConstant.sizedBox24,
                                  Text(
                                    resumeData.description,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),

                                  // * Skills
                                  displaySkills
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SpacerConstant.sizedBox24,
                                            const ResumeCardSubHeaderWidget(
                                              text: "SKILLS DEVELOPED",
                                            ),
                                            SpacerConstant.sizedBox24,
                                            Text(
                                              resumeData.skills,
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  resumeData.achievements,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    // TODO: Implement download functionality for resume
                                                  },
                                                  icon: const Icon(
                                                      Icons.download_outlined),
                                                  padding: EdgeInsets.zero,
                                                  color: Constant
                                                      .backgroundColorDark,
                                                ),
                                              ],
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
    }, error: (e, _) {
      return SliverToBoxAdapter(
        child: ErrorView(
          errorMessage: e.toString(),
          providerClass: getResumeFutureProvider,
        ),
      );
    }, loading: () {
      return const SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    });
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
