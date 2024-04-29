import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:impero_practical_task/screens/color_picker_screen.dart';
import 'package:impero_practical_task/screens/controller/dashboard_controller.dart';
import 'package:get/get.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../utils/common_widget.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with TickerProviderStateMixin {
  late final tabController = TabController(length: 12, vsync: this);
  late DashBoardController dashBoardController;
  @override
  void initState() {
    dashBoardController = Get.put(DashBoardController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.black,
        title: ClipOval(
          child: SizedBox(
            height: 30,
            width: 30,
            child: Image.asset(
              AppImages.imperoLogo,
              fit: BoxFit.fill,
            ),
          ),
        ),
        actions: [
          appBarIcon(iconData: Icons.filter_alt_outlined),
          appBarIcon(iconData: Icons.search),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child:const Icon(Icons.add,color: AppColor.white),
        backgroundColor: AppColor.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ColorPickerScreen();
          },));
        },
      ),
      body: SafeArea(
        child: dashBoardController.dashBoardModel == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColor.black,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: TabBar(
                        isScrollable: true,
                        labelColor: AppColor.black,
                        controller: tabController,
                        padding: EdgeInsets.zero,
                        indicatorColor: Colors.transparent,
                        tabs: [
                          ...dashBoardController.dashBoardModel!.result!.category!.map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                e.name.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dashBoardController.dashBoardModel!.result!.category!.length,
                      itemBuilder: (context, index) {
                        var categoryData = dashBoardController.dashBoardModel!.result!.category![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0) + const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (categoryData.subCategories != null)
                                for (int i = 0; i < categoryData.subCategories!.length; i++) ...{
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      categoryData.subCategories![i].name ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 140,
                                    child: ListView.builder(
                                      itemCount: categoryData.subCategories![i].product!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, imageIndex) {
                                        var productData = categoryData.subCategories![i].product![imageIndex];
                                        return Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: Image.network(
                                                      productData.imageName ?? "",
                                                      fit: BoxFit.cover,
                                                      loadingBuilder: (
                                                        BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent? loadingProgress,
                                                      ) {
                                                        if (loadingProgress == null) {
                                                          return child;
                                                        }
                                                        return const Center(
                                                          child: CircularProgressIndicator(),
                                                        );
                                                      },
                                                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                        return const Icon(Icons.error);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: AppColor.blue,
                                                    ),
                                                    margin: const EdgeInsets.all(16),
                                                    height: 20,
                                                    width: 30,
                                                    child: Center(
                                                      child: Text(
                                                        productData.priceCode ?? "",
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 100,
                                              child: Text(
                                                productData.name ?? "",
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                }
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
