import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_app/business_layer/main_page_layer.dart';
import 'package:stock_app/core/constants/constants.dart';
import 'package:stock_app/pages/list_page.dart';
import 'package:stock_app/product/language/language_items.dart';

import 'package:stock_app/product/model/stock_model.dart';
import 'package:stock_app/product/providers/category_provider/all_providers.dart';

import '../product/providers/stock_provider/all_providers.dart';
import '../product/widgets/app_drawer.dart';
import '../product/widgets/custom_textfield.dart';
import '../product/widgets/dropdown_selection.dart';
import 'home_page.dart';
import 'table_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> with SingleTickerProviderStateMixin {
  BLLMainPage bllMainPage = BLLMainPage();
  late TabController _tabController;
  late TextEditingController _stockNameController;
  late TextEditingController _stockQuantityController;
  var _stockBoxPngLocation = "assets/png/stockbox.png";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _stockNameController = TextEditingController();
    _stockQuantityController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _stockNameController.dispose();
    _stockQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: const Text(LanguageItems.appName)),
      drawer: const AppDrawer(),
      bottomNavigationBar: _tabBar(),
      body: _tabBarView(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomAppBar _tabBar() {
    return BottomAppBar(
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: TabBar(controller: _tabController, tabs: const [
          Tab(
            child: Icon(Icons.home),
          ),
          Tab(
            child: Icon(Icons.transform_outlined),
          ),
          Tab(
            child: Icon(Icons.list),
          )
        ]));
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  child: Wrap(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 100.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0.r),
                            topRight: Radius.circular(25.0.r),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.largePadding,
                              horizontal: AppPadding.largePadding,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 50.h),
                              child: Form(
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      hintText: "Stok ad??",
                                      materialColor: AppColors.superNovaMaterial,
                                      text: "Stok ad??",
                                      isNumber: false,
                                      textController: _stockNameController,
                                    ),
                                    const SizedBox(height: AppSize.mediumSize),
                                    CustomTextField(
                                      textController: _stockQuantityController,
                                      text: "Stok adedi",
                                      hintText: "Stok adedi",
                                      materialColor: AppColors.monteCarloMaterial,
                                      isNumber: true,
                                    ),
                                    const SizedBox(height: AppSize.mediumSize),
                                    const DropDownSelectionWidget(),
                                    const SizedBox(height: AppSize.mediumSize),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              onPrimary: AppColors.white,
                                            ),
                                            onPressed: () {
                                              bllMainPage.addStock(ref, _stockNameController, _stockQuantityController);

                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.add),
                                            label: const Text(
                                              LanguageItems.add,
                                              style: TextStyle(fontSize: AppSize.mediumSize),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Image.asset(_stockBoxPngLocation, height: 150.h, width: 150.w),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding _tabBarView() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.smallPadding),
      child: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          HomePage(),
          TablePage(),
          ListPage(),
        ],
      ),
    );
  }

  pieChart() {
    int touchedIndex = -1;
    return PieChart(PieChartData(
      pieTouchData: PieTouchData(touchCallback: (event, pieTouchResponse) {
        setState(() {
          if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
            touchedIndex = -1;
            return;
          } else {
            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
          }
          print(touchedIndex);
        });
      }),
      borderData: FlBorderData(
        show: false,
      ),
      centerSpaceRadius: 0,
      sectionsSpace: 0,
      startDegreeOffset: 180,
      sections: [
        PieChartSectionData(
          badgeWidget: Text("sat??lanlar"),
          badgePositionPercentageOffset: 1.5,
          value: 75,
          color: AppColors.superNova,
          showTitle: true,
          titleStyle: TextStyle(fontSize: 14),
        ),
        PieChartSectionData(value: 25)
      ],
    ));
  }
}
