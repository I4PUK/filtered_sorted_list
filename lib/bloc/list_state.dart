part of 'list_bloc.dart';

abstract class ListState {
  const ListState();
}

class LoadingListState extends ListState {}

class ListSuccessState extends ListState {
  List<Office> offices;

  ListSuccessState(this.offices);
}

class SortedListState extends ListState {
  List<Office> offices;

  SortedListState(this.offices);
}

class ListLoadingFailedState extends ListState {
  const ListLoadingFailedState();
}
