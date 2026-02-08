import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapollege/view/components/appbar_component.dart';
import 'package:mapollege/view/components/search_component.dart';
import 'package:mapollege/view/presentation/public/search_screen/controller/search_controller.dart';
import 'package:mapollege/view/presentation/public/search_screen/widget/search_drawer_widget.dart';
import 'package:mapollege/view/presentation/public/search_screen/widget/search_list_widget.dart';
import 'package:mapollege/view/presentation/public/search_screen/widget/search_pagination_widget.dart';

class SearchScreen extends GetView<SearchGetController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        resizeToAvoidBottomInset: false,
        endDrawer: const SearchDrawerWidget(),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => controller.refreshResult(),
            child: _SearchScreen(),
          ),
        ),
      ),
    );
  }
}

class _SearchScreen extends GetView<SearchGetController> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        AppbarComponent().sliver(
          title: 'ค้นหา',
          floating: true,
          actions: [
            IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const FaIcon(FontAwesomeIcons.filter),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          sliver: SliverToBoxAdapter(
            child: SearchComponents(
              title: 'ค้นหารายการที่ต้องการ...',
              controller: controller.searchController,
              onChanged: (value) => controller.onSearchChanged(value),
            ),
          ),
        ),
        const SearchListWidget(),
        const SearchPaginationWidget(),
      ],
    );
  }
}
