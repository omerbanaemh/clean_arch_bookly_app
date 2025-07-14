import 'package:clean_arch_bookly_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/use_cases/fetch_similar_books_use_case.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/manger/similar_books_cubit/similar_books_cubit.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/book_details_view.dart';
import 'package:clean_arch_bookly_app/Features/home/presentation/views/home_view.dart';
import 'package:clean_arch_bookly_app/Features/search/presentation/views/search_view.dart';
import 'package:clean_arch_bookly_app/core/utils/functions/setup_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../Features/Splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(
        path: kBookDetailsView,
        builder: (context, state) {
          final book = state.extra;

          if (book == null || book is! BookEntity) {
            return const Scaffold(body: Center(child: Text('Book not found!')));
          }
          return BlocProvider(
            create: (context) => SimilarBooksCubit(
              FetchSimilarBooksUseCase(getIt.get<HomeRepoImpl>())
            )..fetchSimilarBooks(pageNumber: 0),
            child: BookDetailsView(book: book),
          );
        },
      ),
    ],
  );
}
