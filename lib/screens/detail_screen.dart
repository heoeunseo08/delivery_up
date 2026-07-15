import 'package:delivery_up/controller/store_controller.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.storeId});
  final int storeId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  StoreController storeController = StoreController();

  @override
  void initState() {
    super.initState();

  }

  Future<void> load() async {
    storeController.loadDetail(widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("가게 상세 보기"),
      ),
    );
  }
}
