import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/featured_books_cubit/cubit/featured_books_cubit.dart';
import 'package:clean_arch_bookly_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'custom_book_item.dart';

class FeaturedBooksListView extends HookWidget {
  final List<BookEntity> books;

  const FeaturedBooksListView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    final nextPage = useState<int>(1);
    final isLoding = useState<bool>(false);

    useEffect(() {
      Future<void> scrollListener() async {
        var currentPositions = scrollController.position.pixels;
        var maxScrollLength = scrollController.position.maxScrollExtent;
        if (currentPositions >= 0.7 * maxScrollLength) {
          if (!isLoding.value) {
            isLoding.value = true;
            await BlocProvider.of<FeaturedBooksCubit>(
              context,
            ).fetchFeaturedBooks(pageNumber: nextPage.value++);
          }
        }
      }

      scrollController.addListener(scrollListener);

      return () => scrollController.removeListener(scrollListener);
    }, [ScrollController]);

    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
        controller: scrollController,
        itemCount: books.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              GoRouter.of(
                context,
              ).push(AppRouter.kBookDetailsView, extra: books[index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomBookImage(image: books[index].image ?? ''),
            ),
          );
        },
      ),
    );
  }
}
