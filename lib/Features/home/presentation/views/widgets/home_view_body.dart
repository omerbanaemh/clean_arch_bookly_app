import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/featued_books_list_view_bloc_builder.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/newset_book_list_view_builder.dart';
import 'package:clean_arch_bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'custom_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: CustomAppBar(),
              ),
              // FeaturedBooksListView(),
              FeatuedBooksListViewBlocBuilder(),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text('Best Seller', style: Styles.textStyle18),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        const SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: NewsetBookListViewBuilder(),
          ),
        ),
      ],
    );
  }
}
