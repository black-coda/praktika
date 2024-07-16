import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/view/widgets/chip.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const CircleAvatar(
                maxRadius: 15,
                foregroundImage: NetworkImage(
                    "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671116.jpg?w=826&t=st=1717727695~exp=1717728295~hmac=ec1f2b2f76d8254081ea5a1a2bda88801ec3a11cef9f6282030b5ed61c983c19")),
            title: Text("Hello,Johanna",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xffDCC1FF),
                    fontSize: 20,
                    fontWeight: FontWeight.w400)),
            actions: const [
              Icon(
                Icons.notification_important_outlined,
                color: Color(0xff6C6C6C),
              )
            ],
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Wrap(
                spacing: 4.0,
                runSpacing: 0.0,
                children: [
                  ChipWidget(text: "UI/UX"),
                  ChipWidget(text: "Illustrations"),
                  ChipWidget(text: "Graphic Design"),
                  ChipWidget(text: "Marketing"),
                  ChipWidget(text: "Business"),
                  ChipWidget(text: "Web development"),
                  ChipWidget(text: "Mobile development"),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: Text(""),),
          CourseCard(title: "UI/UX Design", price: "199", ratings: "4.5",),
          CourseCard(title: "Advertising Manager", price: "1500", ratings: "4.3"),
          CourseCard(title: "Graphic Design", price: "1200", ratings: "4.7"),
          CourseCard(title: "Python Masterclass", price: "2500", ratings: "4.9"),
          CourseCard(title: "Digital Marketing", price: "199", ratings: "4.5"),
          CourseCard(title: "Mobile App Development", price: "1999", ratings: "4.8"),
          CourseCard(title: "Web Development", price: "199", ratings: "4.5"),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key, required this.title, required this.price, required this.ratings,
  });

  final String title;
  final String price;
  final String ratings;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: 150,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (index % 3 == 0)
                    ? const Color(0xffEC704B)
                    : (index % 3 == 1)
                        ? const Color(0xffF5F378)
                        : const Color(0xffDCC1FF),
              ),
              padding: const EdgeInsets.all(8),
              height: 50,
              width: 240,
              child: Stack(
                //cmainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: const Color(0xff242424),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                        ),
                      ),
                      const Icon(Icons.favorite_border_outlined, size: 20)
                    ],
                  ),
    
                  Positioned(
                    bottom: 50,
                    left: 0,
                    child: Text(
                      "$price \$",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(
                            color: const Color(0xff242424),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                    ),
                  ),
    
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 60,
                            child: ChipElevatedBtn(index: index, ratings: ratings),
                          ),
                          const SizedBox(width: 4),
                          
                        ],
                      )),
    
                  // price, tags,
                  Align(
                    alignment: Alignment.bottomRight,
                    widthFactor: 0,
                    child: SizedBox(
                      height: 100,
                      child: Image.asset(
                        "assets/img_2.png",
                        width: 150,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    ));
  }
}

class ChipElevatedBtn extends StatelessWidget {
 const ChipElevatedBtn({
    super.key,
    required this.index, required this.ratings
  });

  final int index;
  final String ratings;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.star_border_outlined,
          size: 16,
          color: (index % 3 == 0)
              ?  const Color(0xffEC704B)
              : (index % 3 == 1)
                  ? const Color(0xffF5F378)
                  : const Color(0xffDCC1FF)),
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2F2F2F),
          // backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          ),
      label: Text(ratings,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
              color: (index % 3 == 0)
                  ?  const Color(0xffEC704B)
                  : (index % 3 == 1)
                      ? const Color(0xffF5F378)
                      : const Color(0xffDCC1FF))),
    );
  }
}
