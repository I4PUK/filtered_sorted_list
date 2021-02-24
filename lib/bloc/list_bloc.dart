import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_unikoom/models/office/office.dart';
import 'package:test_unikoom/models/offices_list/offices_list.dart';
import 'package:test_unikoom/services/offices_service.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  var officesList = List<Office>();
  ListBloc(ListState initialState) : super(initialState);

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is InitialListEvent) {
      officesList = await _getOfficesList();
      if (officesList.isNotEmpty) {
        yield ListSuccessState(officesList);
      } else {
        yield ListLoadingFailedState();
      }
      return;
    }

    if (event is SortListEvent) {
      yield _sortList();
    }

    if (event is SearchTextFieldChanged) {
      if (event.string.isNotEmpty) {
        final offices = _filterList(event.string);
        yield ListSuccessState(offices);
      } else {
        yield ListSuccessState(officesList);
      }
    }
  }

  List<Office> _filterList(String string) {
    final currentState = this.state;
    if (currentState is ListSuccessState) {
      return currentState.offices.where((office) {
        var officeName = office.name.toLowerCase();
        return officeName.contains(string);
      }).toList();
    }
    if (currentState is SortedListState) {
      return currentState.offices.where((office) {
        var officeName = office.name.toLowerCase();
        return officeName.contains(string);
      }).toList();
    }
    return null;
  }

  Future<List<Office>> _getOfficesList() async {
    final getRequest = await OfficesService.getOfficesList();
    return getRequest.offices;
  }

  ListState _sortList() {
    final currentState = this.state;
    if (currentState is ListSuccessState) {
      currentState.offices
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return SortedListState(currentState.offices);
    }
    if (currentState is SortedListState) {
      currentState.offices = officesList;
      return ListSuccessState(currentState.offices);
    }
    return ListLoadingFailedState();
  }
}
