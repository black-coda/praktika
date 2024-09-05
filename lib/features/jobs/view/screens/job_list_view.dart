import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/app/view/widgets/header.dart';
import 'package:myapp/utils/constant/constant.dart';

import 'career_view.dart';

class JobListView extends ConsumerWidget {
  const JobListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              centerTitle: true,
              pinned: true,
              elevation: 16,
              title: Text(
                'Available Jobs',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            // Job Header

            SliverList.separated(
              separatorBuilder: (context, index) => SpacerConstant.sizedBox20,
              itemBuilder: (context, index) {
                return JobListWidget(
                  index: index,
                );
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class JobListWidget extends StatelessWidget {
  const JobListWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Constant.generateColor(index),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // job company
              const Text("Google"),
              // favorite button
              IconButton(
                  onPressed: () {
                    //TODO:  implement add to favorite
                  },
                  icon: const Icon(Icons.favorite_border_outlined)),
            ],
          ),

          SpacerConstant.sizedBox32,

          // job title
          Text("Junior UI/UX designer",
              style: Theme.of(context).textTheme.headlineSmall),
          SpacerConstant.sizedBox24,

          //* Job payment
          Text("₦100,000 - ₦150,000",
              style: Theme.of(context).textTheme.labelSmall),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //* Job type
              Row(
                children: [
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

              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.3,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constant.backgroundColorDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Apply",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
