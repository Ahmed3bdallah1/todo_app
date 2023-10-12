import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/Authorize/controllers/notifications/notification_helper.dart';
import 'package:todo/features/onboard/dashboard_add_todo.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/reused/app_style.dart';
import 'package:todo/widgets/reused/reusable_text.dart';
import 'package:todo/features/onboard/allTasks.dart';
import 'package:todo/widgets/tiles_widgets/completed_tasks.dart';
import 'package:todo/widgets/tiles_widgets/today_todos.dart';
import 'package:todo/widgets/tiles_widgets/tomorrows_todos.dart';
import 'package:todo/widgets/tiles_widgets/two_days_tasks.dart';
import '../../Authorize/controllers/providers/todo/todo_tile_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  late final NotificationHelper notificationHelper;
  late NotificationHelper control;

  @override
  void initState() {
    notificationHelper = NotificationHelper(ref: ref);
    Future.delayed(Duration.zero, () {
      control = NotificationHelper(ref: ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
      backgroundColor: Constants.kBlueDark.withOpacity(.2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: 'Dashboard',
                        textStyle:
                            appStyle(18, Constants.kLight, FontWeight.bold)),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddTodo()));
                        },
                        child: const Icon(
                          Icons.add,
                          color: Constants.kBlack,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(bottom: 5, right: 10, left: 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: GestureDetector(
                      onTap: () {

                        //to be implemented

                      },
                      child: const Icon(
                        Icons.search,
                        color: Constants.kBlack,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        searchController.clear();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Constants.kBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(CupertinoIcons.paperclip,
                      color: Colors.white, size: 25),
                  const SizedBox(width: 5),
                  ReusableText(
                      text: 'Tasks',
                      textStyle: appStyle(15, Colors.white, FontWeight.bold))
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Constants.kBlueLight.withOpacity(.3),
                    borderRadius: BorderRadius.circular(12)),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      color: Constants.kGreyDark,
                      borderRadius: BorderRadius.circular(12)),
                  controller: tabController,
                  isScrollable: false,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: Constants.kWidth * .5,
                        child: Center(
                            child: ReusableText(
                                text: 'pending',
                                textStyle: appStyle(
                                    15,
                                    Colors.white.withOpacity(.7),
                                    FontWeight.bold))),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: Constants.kWidth * .5,
                        child: Center(
                          child: ReusableText(
                              text: 'completed',
                              textStyle: appStyle(
                                  15,
                                  Colors.white.withOpacity(.7),
                                  FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: Constants.kHeight * .35,
                width: Constants.kWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        color: Constants.kBlueLight.withOpacity(.1),
                        child: const TodayTasks(),
                      ),
                      Container(
                        color: Constants.kBlueLight.withOpacity(.1),
                        child: const CompletedTask(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const TomorrowTasks(),
              const SizedBox(height: 10),
              const TwoDaysTasks(),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AllTasks()));
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.document_scanner_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
