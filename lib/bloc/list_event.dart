part of 'list_bloc.dart';

abstract class ListEvent {
  const ListEvent();
}

class InitialListEvent extends ListEvent {
  const InitialListEvent();
}

class SortListEvent extends ListEvent {
  const SortListEvent();
}

class SearchTextFieldChanged extends ListEvent {
  final String string;

  const SearchTextFieldChanged(this.string);
}
