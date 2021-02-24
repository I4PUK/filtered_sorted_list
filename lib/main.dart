import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_unikoom/bloc/list_bloc.dart';
import 'package:test_unikoom/item_detail.dart';
import 'package:test_unikoom/models/office/office.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) =>
              ListBloc(LoadingListState())..add(InitialListEvent()),
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ListBloc _listBloc;
  int selectedListItem;

  @override
  void initState() {
    super.initState();
    _listBloc = BlocProvider.of<ListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.sort),
              color: Colors.white,
              onPressed: () {
                _listBloc..add(SortListEvent());
              }),
        ],
        title: Text("Список офисов"),
      ),
      body: Column(
        children: [
          searchTextField(),
          SizedBox(height: 8),
          BlocBuilder<ListBloc, ListState>(
            builder: (context, state) {
              if (state is LoadingListState) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is FailedLoadingListState) {
                return Expanded(
                  child: Center(
                    child: Text('Download failed'),
                  ),
                );
              }
              if (state is ListSuccessState) {
                if (state.offices.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text('No posts'),
                    ),
                  );
                }
                return list(state.offices);
              }
              if (state is SortedListState) {
                if (state.offices.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text('No posts'),
                    ),
                  );
                }
                return list(state.offices);
              }
              return Expanded(
                child: Center(
                  child: Text('Error'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget list(List<Office> officesList) {
    return Expanded(
      child: ListView.builder(
        key: Key('builder ${selectedListItem.toString()}'),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            key: Key(index.toString()),
            initiallyExpanded: index == selectedListItem,
            title: Text(officesList[index].name),
            onExpansionChanged: ((newState) {
              if (newState)
                setState(() {
                  selectedListItem = index;
                });
              else
                setState(() {
                  selectedListItem = -1;
                });
            }),
            children: [
              ListTile(
                title: Text(officesList[index].address),
                trailing: trailingListTile(
                  name: officesList[index].name,
                  address: officesList[index].address,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget titleListTile(String title) {
    return InkWell(
      child: Text(title),
      onTap: () {},
    );
  }

  Widget trailingListTile({String name, String address}) {
    return InkWell(
      child: Text(
        'Подробнее',
        style: TextStyle(color: Colors.blueAccent),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetail(
              title: name,
              subtitle: address,
            ),
          ),
        );
      },
    );
  }

  Widget searchTextField() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(
              5.0,
            ),
          ),
        ),
        filled: true,
        fillColor: Colors.white60,
        contentPadding: EdgeInsets.all(16.0),
        hintText: 'Поиск по городам',
      ),
      onChanged: (string) {
        string = string.toLowerCase();
        _listBloc..add(SearchTextFieldChanged(string));
      },
    );
  }
}
