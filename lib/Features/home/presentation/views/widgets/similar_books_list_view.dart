import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/similar_books_cubit/similar_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'custom_book_item.dart';

class SimilarBooksListview extends HookWidget {
  const SimilarBooksListview({super.key, required this.books});

  final List<BookEntity> books;

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
            await BlocProvider.of<SimilarBooksCubit>(context)
            .fetchSimilarBooks(pageNumber: nextPage.value++);
          }
        }
      }

      scrollController.addListener(scrollListener);

      return () => scrollController.removeListener(scrollListener);
    },
    [ScrollController]
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      child: ListView.builder(
        controller: scrollController,
        itemCount: books.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: CustomBookImage(
              image:
                  books[index].image ??
                  'https://www.bigfootdigital.co.uk/wp-content/uploads/2020/07/image-optimisation-scaled.jpg',
            ),
          );
        },
      ),
    );
  }
}
