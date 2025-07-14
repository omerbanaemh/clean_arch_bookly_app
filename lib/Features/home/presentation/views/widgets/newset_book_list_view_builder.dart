import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/newset_books_cubit/newest_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/widgets/newset_books_list_view.dart';
import 'package:clean_arch_bookly_app/core/utils/functions/build_error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NewsetBookListViewBuilder extends HookWidget {
  const NewsetBookListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final  books = useState<List<BookEntity>>([]);


    return BlocConsumer<NewestBooksCubit, NewestBooksState>(
      listener: (context, state) {
        if (state is NewestBooksSuccess) {
          books.value.addAll(state.books);
        }

        if (state is NewestBooksPaginationFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(buildErrorWidget(state.errMessage));
        }
      },
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        if (state is NewestBooksSuccess ||
            state is NewestBooksPaginationLoading ||
            state is NewestBooksPaginationFailure) {
          return NewsetBooksListView(books: books.value);
        } else if (state is NewestBooksFailure) {
          return Text(state.errMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
