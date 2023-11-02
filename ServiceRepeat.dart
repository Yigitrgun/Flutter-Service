import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_learn/101/Studies/servicestudy/service_model.dart';

class ServiceRepeatLearn extends StatefulWidget {
  const ServiceRepeatLearn({super.key});

  @override
  State<ServiceRepeatLearn> createState() => _ServiceRepeatLearnState();
}

class _ServiceRepeatLearnState extends State<ServiceRepeatLearn> {
  List<ServiceModel>? _items;
  String? name;
  bool _isLoading = false;
  late final Dio _dio;
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  late final ServiceModel _serviceModel;
  @override
  //*********************************************************************************** */
  void initState() {
    // TODO: implement initState
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    fetchPostItems();
    name = 'yigit';
  }

//*********************************************************************************** */
  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

//***************************************Func******************************************* */
  Future<void> fetchPostItems() async {
    _changeLoading();
    final response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
    print(response);
    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;
      if (_datas is List) {
        setState(() {
          _items = _datas.map((e) => ServiceModel.fromJson(e)).toList();
        });
      }
      _changeLoading();
    }
    //***************************************Func******************************************** */
    Future<void> fetchPostItemsAdvance() async {
      _changeLoading();
      final response = await _dio.get('posts');
      print(response);
      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;
        if (_datas is List) {
          setState(() {
            _items = _datas.map((e) => ServiceModel.fromJson(e)).toList();
          });
        }
        _changeLoading();
      }
    }
  }

//****************************************APP-Uİ******************************************* */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name ?? ''),
        actions: [_isLoading ? const CircularProgressIndicator.adaptive() : const SizedBox.shrink()],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 20),
            child: ListTile(
              title: Text(_items?[index].title ?? ''),
              subtitle: Text(_items?[index].body ?? ''),
            ),
          );
        },
      ),
    );
  }
}
