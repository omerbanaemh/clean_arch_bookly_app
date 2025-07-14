import 'package:bloc/bloc.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/entities/book_entity.dart';
import 'package:clean_arch_bookly_app/Features/home/domain/use_cases/fetch_similar_books_use_case.dart';
import 'package:meta/meta.dart';

part 'similar_books_state.dart';

class SimilarBooksCubit extends Cubit<SimilarBooksState> {
  SimilarBooksCubit(this.fetchSimilarBooksUseCase) : super(SimilarBooksInitial());

      final FetchSimilarBooksUseCase fetchSimilarBooksUseCase;

  Future<void> fetchSimilarBooks({int pageNumber = 0}) async {
    emit(SimilarBooksLoading());
            if (pageNumber == 0) {
      emit(SimilarBooksLoading());
    } else {
      emit(SimilarBooksPaginationLoading());
    }
    var result = await fetchSimilarBooksUseCase.call(pageNumber);
    result.fold((failure) {
      if (pageNumber == 0) {
        emit(SimilarBooksFailure(failure.message));
      } else {
        emit(SimilarBooksPaginationFailure(failure.message));
      }
    }, (books) {
      emit(SimilarBooksSuccess(books));
    });
  }
}
