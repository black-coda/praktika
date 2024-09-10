import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/features/jobs/view/screens/job_list_view.dart';
import 'package:myapp/features/jobs/view/widget/resume_card_widget.dart';
import 'package:myapp/utils/constant/constant.dart';
import 'package:myapp/utils/extension/extension.dart';

import 'resume_view.dart';

class CareerView extends ConsumerWidget {
  const CareerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          title: const Text(
            'Career',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.favorite_border_outlined,
              ),
              onPressed: () {},
              padding: EdgeInsets.zero,
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
              padding: EdgeInsets.zero,
            ),
            SpacerConstant.sizedBox16,
          ],
          actionsIconTheme: const IconThemeData(
            color: Colors.white,
            size: 24,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeaderWidget("Jobs"),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios,
                      color: Colors.white, size: 16),
                  onPressed: () {
                    context.push(const JobListView());
                  },
                ),
              ],
            ),
          ),
        ),

        //* Jobs list view

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.27,
              child: ListView.separated(
                separatorBuilder: (context, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return JobsWidget(index);
                },
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ),

        //* My Resume Card
        const ResumeCardWidget(navigateTo: ResumeView())
      ],
    );
  }
}

class JobsWidget extends StatelessWidget {
  const JobsWidget(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Constant.generateColor(index),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Google",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_outline),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      //TODO: implement favorite
                    },
                  )
                ],
              ),
              SpacerConstant.sizedBox24,
              //* Job title
              Text("Junior UI/UX designer",
                  style: Theme.of(context).textTheme.headlineSmall),
              SpacerConstant.sizedBox24,

              //* Job payment
              Text("₦100,000 - ₦150,000",
                  style: Theme.of(context).textTheme.labelSmall),

              Row(
                children: [
                  //* Job type
                  JobChipWidget(
                    index: index,
                    title: "Full-time",
                  ),
                  const SizedBox(width: 8),
                  //*job category
                  JobChipWidget(
                    index: index,
                    title: "UI/UX",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobChipWidget extends StatelessWidget {
  const JobChipWidget({
    super.key,
    required this.index,
    required this.title,
  });

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(title),
      selected: false,
      labelPadding: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      disabledColor: Constant.backgroundColorDark,
      backgroundColor: Constant.backgroundColorDark,
      labelStyle: Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(color: Constant.generateColor(index), fontSize: 9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
