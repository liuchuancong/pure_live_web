import 'package:get/get.dart';
import 'popular_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:pure_live_web/core/sites.dart';
import 'package:pure_live_web/common/widgets/index.dart';
import 'package:pure_live_web/modules/popular/popular_controller.dart';

class PopularPage extends GetView<PopularController> {
  const PopularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      bool showAction = constraint.maxWidth <= 680;
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          scrolledUnderElevation: 0,
          leading: showAction ? const MenuButton() : null,
          actions: showAction ? [const SearchButton()] : null,
          title: TabBar(
            tabAlignment: TabAlignment.center,
            controller: controller.tabController,
            isScrollable: true,
            labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: Sites().availableSites().map((e) => Tab(text: e.name)).toList(),
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: Sites().availableSites().map((e) => PopularGridView(e.id)).toList(),
        ),
      );
    });
  }
}
