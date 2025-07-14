import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/featured_books_cubit/cubit/featured_books_cubit.dart';
import 'package:clean_arch_bookly_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'custom_book_item.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({super.key, required this.books});
  
 final List<BookEntity> books;

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {

  late final ScrollController _scrollController;

  int nextPage = 1;
  bool isLoding = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    var currentPositions = _scrollController.position.pixels;
    var maxScrollLength = _scrollController.position.maxScrollExtent;
    if (currentPositions >= 0.7 * maxScrollLength) {
      if(!isLoding){
        isLoding = true;
        await BlocProvider.of<FeaturedBooksCubit>(context)
          .fetchFeaturedBooks(pageNumber: nextPage++);
      } 
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.books.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              GoRouter.of(context).push(AppRouter.kBookDetailsView,extra: widget.books[index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomBookImage(
                image: widget.books[index].image ?? '',
              ),
            ),
          );
        },
      ),
    );
  }
}
