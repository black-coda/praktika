import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/features/jobs/view/screens/edit_resume_view.dart';
import 'package:myapp/features/jobs/view/widget/resume_card_widget.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';

class ResumeView extends ConsumerWidget {
  const ResumeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            leading: BackButton(),
            title: Text(
              'Career',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderWidget("Resume"),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SpacerConstant.sizedBox32),
          ResumeCardWidget(displaySkills: true),
        ],
      ),
    );
  }
}
