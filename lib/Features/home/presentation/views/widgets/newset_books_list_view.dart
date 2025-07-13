import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/newset_books_cubit/newest_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/best_seller_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NewsetBooksListView extends HookWidget {
  const NewsetBooksListView({super.key, required this.books});

  final List<BookEntity> books;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final nextPage = useState(1);
    final isLoading = useState(false);

    useEffect(() {
      void scrollListener() async {
        var currentPositions = scrollController.position.pixels;
        var maxScrollLength = scrollController.position.maxScrollExtent;
        if (currentPositions >= 0.7 * maxScrollLength) {
          if (!isLoading.value) {
            isLoading.value = true;
            await BlocProvider.of<NewestBooksCubit>(context)
                .fetchNewestBooks(pageNumber: nextPage.value++);
            isLoading.value = false;
          }
        }
      }
      scrollController.addListener(scrollListener);
      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.zero,
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: BookListViewItem(book: books[index]),
        );
      },
    );
  }
}