import 'package:flutter/material.dart';

class MyPaginationScreen extends StatefulWidget {
  @override
  _MyPaginationScreenState createState() => _MyPaginationScreenState();
}

class _MyPaginationScreenState extends State<MyPaginationScreen> {
  ScrollController _scrollController = ScrollController();
  // List<int> _dataList = List<int>();
  List<int> _dataList = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 5;

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_currentPage < _totalPages && !_isLoading) {
        _loadData();
      }
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulating an API call delay
    await Future.delayed(Duration(seconds: 2));

    List<int> newData = List<int>.generate(10, (index) => index + 1);
    setState(() {
      _dataList.addAll(newData);
      _isLoading = false;
      _currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination Example'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _dataList.length + 1,
        itemBuilder: (context, index) {
          if (index < _dataList.length) {
            return ListTile(
              title: Text('Item ${_dataList[index]}'),
            );
          } else if (_currentPage < _totalPages) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyPaginationScreen(),
  ));
}
